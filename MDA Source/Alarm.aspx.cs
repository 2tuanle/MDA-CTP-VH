using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI.WebControls;


namespace MDA_CTP
{
    public partial class Alarm : System.Web.UI.Page
    {




        public static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        public static DropDownListHandler Hand = new DropDownListHandler(connectionString);
        
        public static string languages;
        public static string Domain = "Alarm.aspx";
        public static Dictionary<string, List<object>> PackageData;
        public static List<object> PackageData_Alarm = new List<object>();
        //  class Stored Data //  

        // class Stored Lable for Level in Chart  Alarm
        public class RowData
        {
            public string TagDesc { get; set; }
            public string PFC_High { get; set; }
            public string PFC_Low { get; set; }
            public string Active_HighOffset { get; set; }
            public string Active_LowOffset { get; set; }
        }


        protected override void InitializeCulture()
        {
            base.InitializeCulture();
            Session["Language"] = Request.QueryString["lang"];
            string selected = Session["Language"] as string;
            Session["Domain"] = Domain;
            languages = selected;

            if (selected == null)
            {

                selected = "en-US";
                languages = "en-US";

            }

            UICulture = selected;
            Culture = selected;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                Hand.LoadDataToDropDownList1(DropDownList1);
                string localizedText = GetLocalResourceObject("SelectedFactory.Text") as string;
                string localizedData = GetLocalResourceObject("SelectedData.Text") as string;
                string localizedMachine = GetLocalResourceObject("SelectedMachine.Text") as string;
                string Errortext = GetLocalResourceObject("Error.Text") as string;

                RowData LableForLevel = new RowData();
                LableForLevel.PFC_High = GetLocalResourceObject("HighThreshold_Modal.Text") as string;
                LableForLevel.PFC_Low = GetLocalResourceObject("LowThreshold_Modal.Text") as string;
                LableForLevel.Active_HighOffset = GetLocalResourceObject("HighOffset_Modal.Text") as string;
                LableForLevel.Active_LowOffset = GetLocalResourceObject("LowOffset_Modal.Text") as string;

                DropDownList1.Items.Insert(0, new ListItem(localizedText, ""));

                string jsonData = JsonConvert.SerializeObject(LableForLevel);
                languageField.Value = jsonData;
                PlaceHolderMultiple1.Value = localizedMachine;
                PlaceHolderMultiple2.Value = localizedData;

                Error.Value = Errortext;
            }

        }

        // load data for drop down list
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Hand.LoadDataToDropDownList2(DropDownList2, DropDownList1.SelectedValue);
            string localizedLine = GetLocalResourceObject("SelectedLine.Text") as string;
            DropDownList2.Items.Insert(0, new ListItem(localizedLine, ""));
        }


        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            var Machine_Data = Hand.LoadDataToDropDownList3(DropDownList1, DropDownList2);
            StoredAddress.Value = new JavaScriptSerializer().Serialize(Machine_Data);

        }

        [WebMethod]
        public static string LoadDataTagDesc(string Machine_Value, string Location_Value, string Line_Value)
        {
            try
            {
                languages = HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1] as string;
                
            }
            catch (Exception ex)
            {
                languages = "en-US";
            }


            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);
            return Hand.LoadData_TagDesc(Machine_Value, Location_Value, Line_Value, false, true);
        }   

        // Load data Alarm 

        [WebMethod]
        public static string LoadDataAlarm(bool IsActiveAlarmTable, int StartIndex, int RowCount, Dictionary<string, object> PackageData)
        {
            try
            {
                languages = HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1] as string;
            }
            catch
            {
                languages = "en-US";
            }
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);



            List<object> DataSend = Hand.LoadOut_Alarm(IsActiveAlarmTable, StartIndex, RowCount, PackageData);


            return new JavaScriptSerializer().Serialize(DataSend);
        }

        // Update PFC and Confirm the Alarm by User 
        [WebMethod]
        public static void UpdateAlarmStatus(Dictionary<string, object>  packages, bool isChangePFC )
        {

            string packageId = packages["ID"].ToString();
            string[] packageIdArray = { packageId };

            string[] keyNameAlarmTable;
            string[] valueByKey;



            if (FindStatusByID(packageId) != "EndAlarm")
            {

                keyNameAlarmTable = new string[] { "Status", "Reason", "Comment", "Commit_TimeStamp" };
                valueByKey = new string[] { "Monitor", packages["Reason"].ToString(), packages["Comment"].ToString(), DateTime.Now.ToString() };
            }
            else
            {
                keyNameAlarmTable = new string[] { "Reason", "Comment", "Commit_TimeStamp" };
                valueByKey = new string[] { packages["Reason"].ToString(), packages["Comment"].ToString(), DateTime.Now.ToString() };
            }

            string[] keyCondition = new string[] { "ID" };

            // Update PFC Standard if parameters have been set

            if (!isChangePFC) // Check if user set up parameters
            {
                string[] keyNamePFCTable = new string[] { "PFC_High", "PFC_Low", "Active_HighOffset", "Active_LowOffset" };  
                string[] valueByKeyPFCTable = { packages["HighThreshold"].ToString(), packages["LowThreshold"].ToString(), packages["High_Threshold_Calculated"].ToString(), packages["Low_Threshold_Calculated"].ToString() };

                string[] keyConditionPFCTable = new string[] { "TagDesc" ,  "FactoryArea" , "Location" ,  "Line" };
                string[] valueByConditionPFCTable = { packages["TagDesc"].ToString() , packages["FactoryArea"].ToString(), packages["Location"].ToString(), packages["Line"].ToString() };


                Hand.UpdateDataPara("dbo.PFCTable", keyNamePFCTable, valueByKeyPFCTable, keyConditionPFCTable, valueByConditionPFCTable);  
               
            }

            // Update Alarm Table
            if (!string.IsNullOrEmpty(packageId))
            {
                Hand.UpdateInDatabase("dbo.AlarmTable", keyNameAlarmTable, valueByKey, keyCondition, packageIdArray);
            }
        }

        // Load data for chart in popup

        [WebMethod]
        public static string LoadDataPopUp(string Package)
        {

            string[] Packages = Package.Split(',');
            string TagName_Popup = DropDownListHandler.GetTagName(Packages[0]);
            string TimeSelected = Packages[1];
            string TimeScale = !string.IsNullOrWhiteSpace(Packages[2]) ? Packages[2] : "1440";
            DateTime TimeEnd = DateTime.Now;
            try
            {
                TimeEnd = DateTime.Parse(TimeSelected);


            }
            catch (Exception ex)
            {
                TimeEnd = DateTime.Now;
            }

            string formattedDate = TimeEnd.ToString("yyyy-MM-dd HH:mm:ss");

            string TimeStart = TimeEnd.AddMinutes(int.Parse(TimeScale)).ToString("yyyy-MM-dd HH:mm:ss");

            List<object[]> MapDataArray = new List<object[]>();

            try
            {
                languages = HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1] as string;
            }
            catch
            {
                languages = "en-US";
            }

            var Package_Send = Hand.Getdata_Realtime(TagName_Popup, formattedDate, TimeStart, languages);

            // Map data 

            foreach (var TagEntry in Package_Send)
            {
                string tagName = TagEntry.Key;

                List<object> DataList = TagEntry.Value.Item1;

                foreach (dynamic dataPoint in DataList)
                {

                    string intervalStart = dataPoint.IntervalStart;
                    string average = dataPoint.Average;

                    // Create an array with intervalStart and average
                    object[] pair = { intervalStart, average };

                    // Push the pair into the main array
                    MapDataArray.Add(pair);
                }


            }


            return new JavaScriptSerializer().Serialize(MapDataArray);

        }   

        // Load PFC Threshold 

        [WebMethod]
        public static string LoadDataPara(string ID, bool SearchByID , string FactoryArea ,  string Location , string Line)
        {
            try
            {
                languages = HttpContext.Current.Request.UrlReferrer.Query.Split('=')[1] as string;
            }
            catch
            {
                languages = "en-US";
            }

            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
            System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);

            PackageData = Hand.LoadDataPara(ID, SearchByID,  FactoryArea, Location, Line);
            string json = Newtonsoft.Json.JsonConvert.SerializeObject(PackageData);

            return json;
        }

        // Load Work Time in PFC Set Up Page

        [WebMethod]
        public static string LoadDataWorkTime()
        {
            // Load Time Work 
            var TimeWork = Hand.LoadTimeWork();
            string json = Newtonsoft.Json.JsonConvert.SerializeObject(TimeWork);
            return json;
        }

        // Check Status of Alarm signal based ID

        public static string FindStatusByID(string desiredID)
        {
            string status = null; // Initialize status variable

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 1 Status FROM dbo.AlarmTable WHERE id = @ID";

                using (SqlCommand command = new SqlCommand(query, con))
                {
                    command.Parameters.AddWithValue("@ID", desiredID); // Correct parameter name

                    con.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Retrieve status from reader and store it in the status variable
                            status = reader["Status"].ToString();
                        }
                    }
                }
            }

            return status; // Return the status variable
        }

        // Request from user when  New ID appears   

        [WebMethod(EnableSession = true)]
        public static string CheckNewItem(string uniqueId)
        {
            // Construct a unique session key based on the unique identifier provided
            string sessionKey = $"PreviousStatuses_{uniqueId}";

            // Retrieve or initialize the previousStatuses dictionary from the session
            var context = HttpContext.Current;
            var previousStatuses = (Dictionary<int, (string Status, string Type)>)context.Session[sessionKey];
            // Flags to hold different types of changes
            bool isDataChange = false;
            bool isAlarmLevel = false;
            // Create a JSON object to return
            var result = new
            {
                IsDataChange = isDataChange,
                IsAlarmLevel = isAlarmLevel
            };

            if (previousStatuses == null)
            {
                previousStatuses = new Dictionary<int, (string Status, string Type)>();
                context.Session[sessionKey] = previousStatuses;
                return JsonConvert.SerializeObject(result);
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Query to get all relevant records
                string query = @"
                SELECT ID, Status, Type
                FROM dbo.AlarmTable
                WHERE Status IN ('OnGoing', 'Monitor')";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        var currentStatuses = new Dictionary<int, (string Status, string Type)>();
                        var currentIds = new HashSet<int>(); // Store current IDs for quick lookup
                        while (reader.Read())
                        {
                            int id = reader.GetInt32(0);
                            string status = reader.GetString(1);
                            string type = reader.GetString(2);
                            currentStatuses[id] = (status, type);
                            currentIds.Add(id);

                            if (!previousStatuses.ContainsKey(id))
                            {
                                // New record detected
                                isDataChange = true;
                                if (status == "OnGoing" && type == "Alarm")
                                {
                                    isAlarmLevel = true;
                                }
                            }
                            else
                            {
                                var (prevStatus, prevType) = previousStatuses[id];
                                if (prevStatus != status || prevType != type)
                                {
                                    // Status or type change detected
                                    isDataChange = true;
                                    if (status == "OnGoing" && type == "Alarm")
                                    {
                                        isAlarmLevel = true;
                                    }
                                }
                            }
                        }

                        // Check for IDs in previousStatuses that are no longer present in current results
                        foreach (var prevId in previousStatuses.Keys)
                        {
                            if (!currentIds.Contains(prevId))
                            {
                                // An ID from the previous session is no longer in the current data
                                isDataChange = true;
                            }
                        }

                        // Update the previous statuses with current statuses
                        context.Session[sessionKey] = currentStatuses;
                    }
                }

                con.Close();
            }

            // Create a JSON object with updated flags
            result = new
            {
                IsDataChange = isDataChange,
                IsAlarmLevel = isAlarmLevel
            };

            return JsonConvert.SerializeObject(result);
        }

        [WebMethod]
        public static bool DisableAlarm(Dictionary<string, object>  Package)
          {
            string[] keyConditionPFCTable, valueByConditionPFCTable;
            string[] keyNamePFCTable = new string[] { "EnableAlarm" };
            string[] valueByKeyPFCTable = { Package["value"] as string };
            if (string.IsNullOrWhiteSpace(Package["MachineID"] as string))
            {

                keyConditionPFCTable = new string[] { "MachineType", "FactoryArea", "Location"  ,"Line"};
                valueByConditionPFCTable = new string[] { Package["Machine"].ToString(), Package["FactoryArea"].ToString(), Package["Location"].ToString() , Package["Line"].ToString() };
            }
            else
            {

                keyConditionPFCTable = new string[] { "MachineType", "FactoryArea", "Location","Line", "MachineID" };
                valueByConditionPFCTable = new string[] { Package["Machine"].ToString(), Package["FactoryArea"].ToString(), Package["Location"].ToString(), Package["Line"].ToString(), Package["MachineID"].ToString() };
            }
            try
            {


                Hand.UpdateStatusPFC( keyNamePFCTable , valueByKeyPFCTable, keyConditionPFCTable, valueByConditionPFCTable);  
            } catch (Exception ex)
            {
                return false;

            }

            return true;
        }


        [WebMethod(EnableSession = true)]
        public static string LoadstatusDisableAlarm(Dictionary<string, object> Package)
        {

            string[] keyConditionPFCTable, valueByConditionPFCTable;
            
            

            if (!string.IsNullOrWhiteSpace(Package["Machine"] as string))
            {

                keyConditionPFCTable = new string[] { "MachineType", "FactoryArea", "Location" , "Line" };
                valueByConditionPFCTable = new string[] { Package["Machine"].ToString(), Package["FactoryArea"].ToString(), Package["Location"].ToString() , Package["Line"].ToString() };
            }
            else
            {

                keyConditionPFCTable = new string[] {  "FactoryArea", "Location"};
                valueByConditionPFCTable = new string[] {Package["FactoryArea"].ToString(), Package["Location"].ToString() };
            }

            List<object> result = Hand.LoadStatusPFC(keyConditionPFCTable, valueByConditionPFCTable);




            return JsonConvert.SerializeObject(result);
        }

    }





}




