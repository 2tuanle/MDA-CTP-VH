using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Diagnostics;
using System.Globalization;
using System;
using static MDA_CTP.Alarm;
using Newtonsoft.Json;


namespace MDA_CTP
{
    public partial class HistoryData : System.Web.UI.Page
    {
       
        public static string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        public static DropDownListHandler Hand = new DropDownListHandler(connectionString);
        
        // Variable to store the data 

        public static Dictionary<string, Tuple<List<object>, List<object>>> DataAverage = new Dictionary<string, Tuple<List<object>, List<object>>>();
        public static Dictionary<string, Tuple<List<object>, List<object>>> DataRealTime = new Dictionary<string, Tuple<List<object>, List<object>>>();
        public static Dictionary<string, List<object>> DataSend = new Dictionary<string, List<object>>();

        // Variable to set the limit of a package

        public static int dateoffset = 1;
        public static int offset_loop = 0;  
        public static int size_limmit = 25000;  
        public static bool flag_track = false;
        public static int previous_startindex = 0;
        public static int offset_index = 0;
        // class Stored Lable for Level in Chart  Alarm
        public class RowData
        {
            public string TagDesc { get; set; }
            public string PFC_High { get; set; }
            public string PFC_Low { get; set; }
            public string Active_HighOffset { get; set; }
            public string Active_LowOffset { get; set; }
        }



        // Session languages //  

        public static string languages;

        public static string Domain = "HistoryData.aspx";
        protected override void InitializeCulture()
        {
            base.InitializeCulture();

            Session["Language"] = Request.QueryString["lang"];
            string selected = Session["Language"] as string;
            Session["Domain"] = Domain;
            languages = selected;  

            if(selected == null )
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


                // Load lable from local Resource

                string localizedText = GetLocalResourceObject("SelectedFactory.Text") as string;
                string localizedLine = GetLocalResourceObject("SelectedLine.Text") as string;
                string localizedData = GetLocalResourceObject("SelectedData.Text") as string;
                string localizedMachine = GetLocalResourceObject("SelectedMachine.Text") as string;

                DropDownList1.Items.Insert(0, new ListItem(localizedText, ""));
                DropDownList2.Items.Insert(0, new ListItem(localizedLine, ""));
                Placeholder_Machine_text.Value = localizedMachine;
                Placeholder_Data_text.Value= localizedData; 



                RowData LableForLevel = new RowData();
                LableForLevel.PFC_High = GetLocalResourceObject("HighThreshold_Modal.Text") as string;
                LableForLevel.PFC_Low = GetLocalResourceObject("LowThreshold_Modal.Text") as string;
                LableForLevel.Active_HighOffset = GetLocalResourceObject("HighOffset_Modal.Text") as string;
                LableForLevel.Active_LowOffset = GetLocalResourceObject("LowOffset_Modal.Text") as string;

                string jsonData = JsonConvert.SerializeObject(LableForLevel);
                languageField.Value = jsonData;
                base.InitializeCulture();
      
              

            }

            // Set initial/default value for each dropdown list

        }


         // Load out option for drop down list
        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Hand.LoadDataToDropDownList2(DropDownList2, DropDownList1.SelectedValue);
            string localizedLine = GetLocalResourceObject("SelectedLine.Text") as string;
            DropDownList2.Items.Insert(0, new ListItem(localizedLine, ""));
        }


        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            var Machine_Data = Hand.LoadDataToDropDownList3(DropDownList1, DropDownList2);
            Data_TagName_Receive.Value = new JavaScriptSerializer().Serialize(Machine_Data);

        }

        [WebMethod]
        public static string LoadData_TagDesc(string Machine_Value, string Location_Value, string Line_Value)
        {
            try
            {
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);
                return Hand.LoadData_TagDesc(Machine_Value, Location_Value, Line_Value, false ,true);

            }
            catch (Exception ex)
            {
                // Handle exceptions/log errors
                System.Diagnostics.Debug.WriteLine(ex.Message);
                return null;
            }
        }
       
        // Load Data Average 

        [WebMethod]
        public static string Load_Data_Average(string values, int chunkIndex)
        {
            var value = values.Split(',');
            var Tagname = string.Join(",", value.Skip(3));
            var tagNames = DropDownListHandler.GetTagName(Tagname);

         
            if (chunkIndex == 0)
            {
                offset_loop = 0;  
                offset_index = 0;
                DataAverage = DropDownListHandler.GetDataByTagName(tagNames, value[0], value[1], value[2], languages);

            }
            var Signal = GetNextChunk(chunkIndex, DataAverage);


            return Signal;
            
        }
            
        
        // Load Data Real Time 

        [WebMethod]
        public static string Load_Data_RealTime(string values, int chunkIndex)
        {
            var value = values.Split(',');
            var Tagname = string.Join(",", value.Skip(3));
            var tagNames = DropDownListHandler.GetTagName(Tagname);
            // string[] tagNamesArray = tagNames.Split(new string[] { ", " }, StringSplitOptions.None);
           
            
            if (chunkIndex == 0)
            {
                offset_loop = 0;  
                offset_index = 0;  
                string dateString = value[1];
                DateTime Startday, endDay;

                if (value[1] != " undefined:00")
                    {
                        if (DateTime.TryParseExact(dateString, "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out Startday))
                        {
                            DateTime dayend = Startday.AddDays((double)HistoryData.dateoffset);
                            string formattedDate = dayend.ToString("yyyy-MM-dd HH:mm:ss");
                            if (value[2] == " undefined:00")
                            {
                                value[2] = formattedDate;
                            }
                            else if (DateTime.Compare(DateTime.ParseExact(value[2], "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture), dayend) > 0)
                            {
                                value[2] = formattedDate;
                            }
                        }
                }
                else if (value[2] != " undefined:00" && DateTime.TryParseExact(value[2], "yyyy-MM-dd HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out endDay))
                {
                        DateTime daystart = endDay.AddDays((double)(-HistoryData.dateoffset));
                        value[1] = daystart.ToString("yyyy-MM-dd HH:mm:ss");
                }
                   
                    DataRealTime = Hand.Getdata_Realtime(tagNames, value[1], value[2],languages);
            }

            var Signal = GetNextChunk(chunkIndex, DataRealTime);

            return Signal;
        
        }

        // Divide data into small pieces and Transfer it  

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public static string GetNextChunk(int chunkIndex, Dictionary<string, Tuple<List<object>, List<object>>> tagData2)
        {
            Stopwatch stopwatch = new Stopwatch();

            stopwatch.Start();
            const int chunkSize = 1;
            int startIndex = chunkIndex * chunkSize;

            if (chunkIndex == 0)
            {
                DataSend.Clear();

                foreach (var item in tagData2)
                {
                    var tagName = item.Key; // Assuming tagName is obtained from 'item.Key'
                    var dataList = item.Value.Item1; // Assuming list of objects is obtained from 'item.Value'
                    
                    if (!DataSend.ContainsKey(tagName))
                    {
                        DataSend[tagName] = dataList.ToList(); // Add a new entry for the tagName

                        DataSend[tagName].Add(item.Value.Item2);
                    }
                    else
                    {

                        foreach (var data in dataList)
                        {
                            if (!DataSend[tagName].Contains(data))
                            {
                                DataSend[tagName].Add(data); // Add unique elements to the existing list for tagName
                            }
                        }
                    }
                }
            }
            

            if (chunkIndex == 0)
            {

                flag_track = false;

            }



            List<Dictionary<string, List<object>>> dataPacks = new List<Dictionary<string, List<object>>>();
            Dictionary<string, List<object>> halfPackData = new Dictionary<string, List<object>>();
          
            var size_package = 0;
            var _startIndex = 0;
            var break_flag = false ;
            while (true)
            {
                if(break_flag == true)
                {
                    break;
                }
                if (flag_track == false)
                {
                    _startIndex = (startIndex + offset_index + offset_loop) / 2;
                    previous_startindex = _startIndex;
                }
                else
                {
                    _startIndex = previous_startindex;
                }

                if(_startIndex > DataSend.Count-1)
                {
                  
                    break;  
                }
                var pack = DataSend.Skip(_startIndex).Take(chunkSize)
                                    .ToDictionary(entry => entry.Key, entry => entry.Value.ToList());



                foreach (var kvp in pack)
                {
                    string key = kvp.Key; // Get the key

                    if (pack.TryGetValue(key, out List<object> dataList))
                    {

                        double halfCount = (double)dataList.Count / 2; // Calculate half of the count
                        halfCount = (int)Math.Ceiling(halfCount);
                        List<object> halfData = new List<object>();
                        


                        if ((size_package + dataList.Count) < size_limmit)
                        {
                            if (dataList.Count > size_limmit)
                            {
                                if (flag_track == false)
                                {
                                    halfData = dataList.Take(dataList.Count / 2).ToList(); // Retrieves the first half of the data
                                    flag_track = !flag_track;
                                }
                                else
                                {
                                    halfData = dataList.Skip(dataList.Count / 2).Take((int)halfCount).ToList(); // Retrieves the second half of the data
                                    flag_track = !flag_track;
                                }
                            }
                            else
                            {
                                offset_index += 1;
                                halfData = dataList.Take(dataList.Count).ToList();
                                flag_track = false;
                            }
                            // Add the half data to the new dictionary
                            halfPackData.Add(key, halfData);

                            size_package += dataList.Count;
                            offset_loop++;   
                        }
                        else
                        {
                            offset_loop--;
                            break_flag = true;  
                            break;      


                        }
                    }
                    else
                    {
                        // Handle the case when the key doesn't exist in the dictionary
                        Debug.WriteLine($"Key '{key}' not found.");
                    }
                }

                dataPacks.Clear(); // Clear existing content
                dataPacks.Add(pack);
            }
            
            string sortedResultChunksJson = new JavaScriptSerializer().Serialize(halfPackData);
            
            stopwatch.Stop();

            TimeSpan ts = stopwatch.Elapsed;

            string elapsedTime = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
                ts.Hours, ts.Minutes, ts.Seconds,   
                ts.Milliseconds / 10);
            //System.Diagnostics.Debug.WriteLine("RunTime " + ts);
           
            return sortedResultChunksJson;
        }

    }
}




