using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Text;
using System;



public class DropDownListHandler
{
    protected static string _Table_Name;
    protected static string _Factory_value;
    protected static string _Line_value;
    protected static string _TagName;
    protected static string _languages;
    private static string _connectionString;
    private static string _TagName_String;  // Store the TagName String //  
    public static DateTime Pre_date;
    public static int count1 = 0;
    public static float average_value = 0;
    public static bool Flag_add_value = false;
    // Stored data PFC //  
    public class DataStandard
    {
        public string TagDesc { get; set; }
        public string PFC_High { get; set; }
        public string PFC_Low { get; set; }
        public string Active_HighOffset { get; set; }
        public string Active_LowOffset { get; set; }
    } //

    public class WorkTime
    {
        public string StartWorkTime { get; set; }
        public string StartBreakTime { get; set; }
        public string EndWorkTime { get; set; }
        public string EndBreakTime { get; set; }
    }




    public DropDownListHandler(string connectionString)
    {

        _connectionString = connectionString;
        _Factory_value = "s2";
        _Line_value = "1";

    }

    public void Update_Languages(string languages)
    {
        _languages = languages; 
        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(_languages);
        System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(_languages);

    }

    public void LoadDataToDropDownList1(DropDownList DropDownList1)
    {
        using (SqlConnection con = new SqlConnection(_connectionString))
       
        {
            con.Open();
            string query = "SELECT DISTINCT Location FROM dbo.TagMapping";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    DropDownList1.DataSource = reader;
                    DropDownList1.DataValueField = "Location";
                    DropDownList1.DataTextField = "Location";
                    DropDownList1.DataBind();
                }
            }
        }
    }


    public void LoadDataToDropDownList2(DropDownList DropDownList2, string _SelectedOption1)
    {
        string selectedValue = _SelectedOption1;
        //  string connectionString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();
            string query = "SELECT DISTINCT Line FROM dbo.TagMapping WHERE Location = @SelectedValue";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@SelectedValue", selectedValue);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    DropDownList2.DataSource = reader;
                    DropDownList2.DataValueField = "Line";
                    DropDownList2.DataTextField = "Line";
                    DropDownList2.DataBind();

                }
            }
        }
    }


    public string LoadData_TagName(string _Line_value, string _Factory_value)
    {
        string[] _Line_value_Split = _Line_value.Split(',');
        List<string> _Line_value_List = new List<string>(_Line_value_Split);

        string[] _Factory_value_Split = _Factory_value.Split(',');
        List<string> _Factory_value_List = new List<string>(_Factory_value_Split);


        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();
            string query = "SELECT DISTINCT TagName FROM dbo.TagMapping WHERE Location IN ({0})" +
                "AND Line IN ({1})";

            string Line_parameterNames = string.Join(",", _Line_value_List.Select((s, i) => "@_Line_value_List" + i));
            string Factory_parameterNames = string.Join(",", _Factory_value_List.Select((s, i) => "@_Factory_value_List" + i));

            // Modify the query with the parameter placeholders
            query = string.Format(query, Factory_parameterNames, Line_parameterNames);

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                for (int i = 0; i < _Line_value_List.Count; i++)
                {

                    string parameterName = "@_Line_value_List" + i;
                    cmd.Parameters.AddWithValue(Line_parameterNames, _Line_value_List[i]);
                }

                for (int i = 0; i < _Factory_value_List.Count; i++)
                {

                    string parameterName = "@_Factory_value_List" + i;
                    cmd.Parameters.AddWithValue(Factory_parameterNames, _Factory_value_List[i]);
                }

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var database = new DataTable();
                    database.Load(reader);

                    var data = new List<object>();

                    foreach (DataRow row in database.Rows)
                    {


                        string Label_TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", row["TagDesc"] as string + ".Text") as string;


                        data.Add(new { Label = Label_TagDesc, Value = row["TagDesc"] });

                    }

                    con.Close();
                    return data.ToString();
                }

            }
        }

    }
        
    public string LoadData_TagDesc(string Machine_Value, string Location_Value, string Line_Value , bool EnableFullLoad ,  bool EnableJavaScriptSerializer)
    {

        string[] values = !string.IsNullOrEmpty(Machine_Value) ? Machine_Value.Split(',') : new string[] { "" }; //  add add 

        List<string> valueList = new List<string>(values);
        bool IsLoadAll = false;
        string query, TagDesc_String = "";


        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();

            // Check the Drop Down List Value 
            if ((string.IsNullOrWhiteSpace(Location_Value) || string.IsNullOrWhiteSpace(Line_Value) || string.IsNullOrWhiteSpace(Machine_Value)) && EnableFullLoad )
            {
                IsLoadAll = true;

            }

            if (IsLoadAll)
            {
                query = "SELECT DISTINCT TagDesc FROM dbo.TagMapping";
            }
            else
            {
                query = "SELECT DISTINCT TagDesc FROM dbo.TagMapping WHERE Location = @SelectedValue1 " +
                    "AND Line = @SelectedValue2 AND MachineType IN ({0})";

            }
            if (( IsLoadAll) == false)
            {
                // Create parameter placeholders for the IN clause based on the number of values in valueList
                string parameterNames = string.Join(",", valueList.Select((s, i) => "@SelectedValue3_" + i));

                // Modify the query with the parameter placeholders
                query = string.Format(query, parameterNames);
            }

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if ((IsLoadAll) == false)
                {
                    for (int i = 0; i < valueList.Count; i++)
                    {
                        // System.Diagnostics.Debug.WriteLine(Session["Language"]);
                        string parameterName = "@SelectedValue3_" + i;
                        cmd.Parameters.AddWithValue(parameterName, valueList[i]);
                    }
                    cmd.Parameters.AddWithValue("@SelectedValue1", Location_Value);
                    cmd.Parameters.AddWithValue("@SelectedValue2", Line_Value);
                }
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var database = new DataTable();
                    database.Load(reader);

                    var data = new List<object>();

                    foreach (DataRow row in database.Rows)
                    {
                        string Label_TagDesc = !string.IsNullOrWhiteSpace(HttpContext.GetLocalResourceObject("~/HistoryData.aspx", row["TagDesc"] as string + ".Text") as string) ?
                                            HttpContext.GetLocalResourceObject("~/HistoryData.aspx", row["TagDesc"] as string + ".Text") as string : row["TagDesc"] as string; 

                        if (EnableJavaScriptSerializer)
                            data.Add(new { Label = Label_TagDesc, Value = row["TagDesc"] });
                        else
                        {
                            if (TagDesc_String.Length > 0)
                            {
                                TagDesc_String += ",";
                            }
                            TagDesc_String += row["TagDesc"];
                        }

                    }

                    con.Close();
                    return ((EnableJavaScriptSerializer == true) ? new JavaScriptSerializer().Serialize(data) : TagDesc_String);

                }
            }
        }
    }

    public List<object> LoadDataToDropDownList3(DropDownList DropDownList1, DropDownList DropDownList2)
    {

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();
            string query = "SELECT DISTINCT MachineType FROM dbo.TagMapping WHERE Location = @SelectedValue1 AND Line = @SelectedValue2";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@SelectedValue1", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@SelectedValue2", DropDownList2.SelectedValue);
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var dt = new DataTable();
                    dt.Load(reader);


                    var data = new List<object>();
                    foreach (DataRow row in dt.Rows)
                    {
                        //Debug.WriteLine("Culture: " + System.Threading.Thread.CurrentThread.CurrentCulture.Name);
                        //Debug.WriteLine("UICulture: " + System.Threading.Thread.CurrentThread.CurrentUICulture.Name);
                        string Label_Machine = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", row["Machinetype"] as string + ".Text") as string;


                        data.Add(new { Label = Label_Machine, Value = row["MachineType"] });
                    }

                    con.Close();
                    return data;
                }
            }



        }
    }


    // Load out Alarm data 
    public List<object> LoadOut_Alarm(bool IsActiveAlarmTable, int startIndex, int RowCount, Dictionary<string, object> PackageData)
    {

        string Tagname;
        // Check if it's the first load
        if (startIndex == 0) 
        { 
            if (string.IsNullOrWhiteSpace(PackageData["TagDesc"].ToString())) 
            {
                var TagDesc = LoadData_TagDesc(null, null, null, true, false);
                Tagname = GetTagName(TagDesc);

            }
            else // Load out Data from DropDownList // 
            {
                Tagname = GetTagName(PackageData["TagDesc"].ToString());
            }
            _TagName_String = Tagname; 
        }
        else
        {
            Tagname = _TagName_String; // Get the last TagName to load the next Data Package 
        }

        return get_AlarmData(Tagname, IsActiveAlarmTable, startIndex, RowCount , PackageData);

    }

    public static string GetTagName(string tagDescString)
    {
        try
        {
            // Handle null or empty input
            if (string.IsNullOrEmpty(tagDescString))
            {
                return null;
            }

            // Process data
            string[] values = tagDescString.Split(',');
            List<string> valueList = new List<string>(values);

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                con.Open();

                // Parameterized query to prevent SQL injection
                StringBuilder queryBuilder = new StringBuilder();
                queryBuilder.Append("SELECT DISTINCT TagName FROM dbo.TagMapping ");
                queryBuilder.Append("WHERE TagDesc IN (");

                // Create parameter placeholders for the IN clause
                for (int i = 0; i < valueList.Count; i++)
                {
                    if (i > 0)
                    {
                        queryBuilder.Append(",");
                    }
                    queryBuilder.Append("@SelectedValue" + i);
                }
                queryBuilder.Append(")");

                // Execute the query
                using (SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), con))
                {
                    for (int i = 0; i < valueList.Count; i++)
                    {
                        cmd.Parameters.AddWithValue("@SelectedValue" + i, valueList[i]);
                    }

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        List<string> tagNames = new List<string>();
                        while (reader.Read())
                        {
                            string tagName = reader["TagName"].ToString(); // Get the value from the reader
                            tagNames.Add(tagName);
                        }
                        return string.Join(",", tagNames);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            // Handle exceptions/log errors
            System.Diagnostics.Debug.WriteLine("Error occurred: " + ex.Message);
            return null;
        }
    }


    // Function - History Page 

    public Dictionary<string, Tuple<List<object>, List<object>>> Getdata_Realtime(string tagNames, string startTime, string endTime , string languages)
    {
        Dictionary<string, Tuple<List<object>, List<object>>> tagData = new  Dictionary<string, Tuple<List<object>, List<object>>>();

        string Previous_Timestamp = "";
        string[] tagArray = tagNames.Split(',');

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            try
            {
                connection.Open();
                
                foreach (string tagName in tagArray)
                {

                    // Load out Data[ Value ; Time ]

                    List<object> dataForTag = new List<object>();

                    using (SqlCommand command = new SqlCommand("HistoryData", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        // Add parameters to the stored procedure
                        command.Parameters.AddWithValue("@TagNames", tagName);
                        command.Parameters.AddWithValue("@StartTime", startTime);
                        command.Parameters.AddWithValue("@EndTime", endTime);

                        SqlDataReader reader = command.ExecuteReader();

                        string previousTagDesc = null;

                        while (reader.Read())
                        {




                            string column5Value = reader["TagDesc"].ToString();
                            string column2Value = reader["TimeStamp"].ToString();
                            // string column3 = reader["Value"].ToString();


                            if (Previous_Timestamp != column2Value)
                            {
                                if (column5Value != previousTagDesc)
                                {

                                    //string column2Value = reader["TimeStamp"].ToString();
                                    string column3Value = reader["Value"].ToString();
                                    //  string column4Value = reader["intervalEnd"].ToString();
                                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);

                                    string Label_TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", column5Value as string + ".Text") as string;

                                    dataForTag.Add(new
                                    {
                                        IntervalStart = column2Value,
                                        Average = column3Value,
                                        TagDesc = Label_TagDesc
                                        //  IntervalEnd = column4Value 
                                    });

                                    previousTagDesc = column5Value; // Update previousTagDesc
                                }
                                else
                                {
                                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("en-US");
                                    // string column2Value = reader["TimeStamp"].ToString();
                                    string column3Value = reader["Value"].ToString();
                                    // string column4Value = reader["intervalEnd"].ToString();
                                    //Previous_Timestamp = column2Value;
                                    dataForTag.Add(new
                                    {
                                        IntervalStart = reader["TimeStamp"].ToString(),
                                        Average = column3Value,
                                        TagDesc = ""
                                        // IntervalEnd = column4Value 
                                    });

                                }

                                Previous_Timestamp = column2Value;
                            }
                            else
                            {
                                
                            }

                        }

                        reader.Close();
                    }
                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);
                    // Load out TagDesc , Unit , ...  push them into List Object
                    List<object> SubData  = LoadoutDatabase("dbo.TagMapping", new string[] { "TagDesc", "Unit" ,"TagCat" }, new string[] { "TagName" }, new string[] { tagName }); 

                    string TagDesc_key = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", tagName as string + ".Text") as string;
                    tagData.Add(tagName, new Tuple<List<object>, List<object>> (dataForTag,SubData));
                }
            }
            catch (Exception ex)
            {   
                System.Diagnostics.Debug.WriteLine(ex.Message);
                // Consider logging the exception for better error handling
            }
            finally
            {
                connection.Close();
            }
        }

        return tagData;
    }

    public static Dictionary<string, Tuple<List<object>, List<object>>> GetDataByTagName(string tagNames, string timeInterval, string startTime, string endTime , string languages)
    {
        Dictionary<string, Tuple<List<object>, List<object>>> tagData = new Dictionary<string, Tuple<List<object>, List<object>>>();
        Dictionary<string, Tuple<List<object>, List<object>>> tagData_forday = new Dictionary<string, Tuple<List<object>, List<object>>>();

        Pre_date = new DateTime();


        
        string[] tagArray = tagNames.Split(',');

        using (SqlConnection connection = new SqlConnection(_connectionString))
        {
            try
            {
                connection.Open();

                foreach (string tagName in tagArray)
                {
                    List<object> dataForTag = new List<object>();
                    Pre_date = new DateTime();
                    using (SqlCommand command = new SqlCommand("AverageData", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        string tt = (timeInterval == "1440") ? "60" : timeInterval;
                        // Add parameters to the stored procedure
                        command.Parameters.AddWithValue("@TimeInterval", tt);
                        command.Parameters.AddWithValue("@StartTime", startTime);
                        command.Parameters.AddWithValue("@EndTime", endTime);
                        command.Parameters.AddWithValue("@TagNames", tagName);

                        SqlDataReader reader = command.ExecuteReader();

                        string previousTagDesc = null;
                        var count = 0;
                        while (reader.Read())
                        {
                            count++;

                            string column5Value = reader["TagDesc"].ToString();
                            if (timeInterval != "1440")
                            {
                                if (column5Value != previousTagDesc)
                                {

                                    string column2Value = reader["intervalStart"].ToString();
                                    string column3Value = reader["Average"].ToString();
                                    //  string column4Value = reader["intervalEnd"].ToString();
                                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);

                                    string Label_TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", column5Value as string + ".Text") as string;
                                    dataForTag.Add(new
                                    {
                                        IntervalStart = column2Value,
                                        Average = column3Value,
                                        TagDesc = Label_TagDesc
                                        //  IntervalEnd = column4Value 
                                    });

                                    previousTagDesc = column5Value; // Update previousTagDesc
                                }


                                else
                                {
                                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("en-US");
                                    string column2Value = reader["intervalStart"].ToString();
                                    // DateTime date12 = DateTime.Parse(column2Value);
                                    string column3Value = reader["Average"].ToString();
                                    // string column4Value = reader["intervalEnd"].ToString();
                                    dataForTag.Add(new
                                    {
                                        IntervalStart = column2Value,
                                        Average = column3Value,
                                        TagDesc = ""
                                        // IntervalEnd = column4Value 
                                    });

                                }
                            }
                            else
                            {

                                String day = reader["intervalStart"].ToString();
                                DateTime date1 = DateTime.Parse(day);

                                DateTime date = date1.Date;

                                DateTime date2 = DateTime.Parse(endTime);

                                DateTime date_end = date2.Date;
                                TimeSpan time = date1.TimeOfDay;

                                TimeSpan startTime1 = new TimeSpan(7, 20, 0); // 7:20:00 AM
                                TimeSpan end_Time1 = new TimeSpan(10, 20, 0); // 4:30:00 PM
                                TimeSpan startTime2 = new TimeSpan(12, 20, 0); // 4:30:00 PM
                                TimeSpan end_Time2 = new TimeSpan(16, 30, 0); // 4:30:00 PM
                                DateTime check_first = DateTime.Parse(startTime).Date;
                                //add-on//  
                                string check_string = reader["Average"].ToString();
                                if ((((time >= startTime1 && time <= end_Time1) || (time >= startTime2 && time <= end_Time2)) && (check_string != "")) ||
                                    ((Pre_date == date2) && ((time >= startTime1 && time <= end_Time1) || (time >= startTime2))
                                    ) && (Pre_date <= date1))
                                {
                                    //System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                                    //System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);
                                    if (Pre_date == date || date == check_first || Pre_date.ToString() == "1/1/0001 12:00:00 AM")
                                    {


                                        Flag_add_value = false;
                                        float test = 0;
                                        if (check_string != "")
                                        {
                                            test = float.Parse(check_string);
                                            // System.Diagnostics.Debug.WriteLine("check");
                                            // System.Diagnostics.Debug.WriteLine(float.Parse("62.17"));
                                            if ((test != 0))
                                            {
                                                average_value = average_value + test;
                                                count1++;
                                            }
                                        }
                                        TimeSpan currentTime = DateTime.Now.TimeOfDay;
                                        if (Pre_date == date2 && ((time - currentTime).TotalMinutes < 60))
                                        {
                                            average_value = average_value / (float)count1;

                                            dataForTag.Add(new
                                            {
                                                IntervalStart = Pre_date.ToString(),
                                                Average = ((average_value.ToString() == "NaN") ? "" : average_value.ToString()),
                                                TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["TagDesc"].ToString() + ".Text") as string
                                            });

                                            count1 = 0;
                                            average_value = 0;

                                            break;
                                        }

                                    }
                                    else if (average_value.ToString() != "NaN" || average_value != -1)
                                    {
                                        // caculte the average // 

                                        average_value = average_value / (float)count1;

                                        dataForTag.Add(new
                                        {
                                            IntervalStart = Pre_date.ToString(),
                                            Average = ((average_value.ToString() == "NaN") ? "" : average_value.ToString()),
                                            TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["TagDesc"].ToString() + ".Text") as string
                                        });

                                        count1 = 0;
                                        average_value = 0;
                                        average_value = average_value + float.Parse(reader["Average"].ToString());
                                        count1++;
                                    }

                                    Pre_date = date;
                                }
                                else if (average_value != 0 && ((time == new TimeSpan(16, 20, 0))) && count1 != 8)
                                {
                                    average_value = average_value / (float)count1;

                                    dataForTag.Add(new
                                    {
                                        IntervalStart = Pre_date.ToString(),
                                        Average = ((average_value.ToString() == "NaN") ? "" : average_value.ToString()),
                                        TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["TagDesc"].ToString() + ".Text") as string
                                    });

                                    count1 = 0;
                                    average_value = 0;
                                    Pre_date = Pre_date.AddDays(1);
                                }


                            }


                        }

                        reader.Close();
                    }

                    // add sub data//  

                    System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(languages);
                    System.Threading.Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo(languages);
                    // Load out TagDesc , Unit , ...  push them into List Object
                    List<object> SubData = LoadoutDatabase("dbo.TagMapping", new string[] { "TagDesc", "Unit", "TagCat" }, new string[] { "TagName" }, new string[] { tagName });

                    string TagDesc_key = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", tagName as string + ".Text") as string;
                   


                    if (timeInterval != "1440")
                    {
                        tagData.Add(tagName,new Tuple<List<object>, List<object>>( dataForTag, SubData));
                    }
                    else
                    {
                        tagData_forday.Add(tagName, new Tuple<List<object>, List<object>>(dataForTag, SubData));
                    }

                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
                // Consider logging the exception for better error handling
            }
            finally
            {
                connection.Close();
            }
        }

        return (timeInterval == "1440") ? tagData_forday : tagData;
    }



    // Function - Alarm Page 

    private static List<object> get_AlarmData(string Tag_Name, bool IsActiveAlarmTable, int startIndex, int rowCount , Dictionary<string, object> Package_Filter)
    {
        string[] values = Tag_Name.Split(',');
        List<string> valueList = new List<string>(values);

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();

            string query = "SELECT * FROM dbo.AlarmTable WHERE TagName IN ({0}) ";

            // Add filter conditions
            if (!string.IsNullOrWhiteSpace(Package_Filter["ID"].ToString()))
            {
                query += "AND ID <= @ID";
            }
            //if (!string.IsNullOrWhiteSpace(Package_Filter["TagDesc"].ToString())) query += "AND TagName = @PackageValue_1 ";
            if (!string.IsNullOrWhiteSpace(Package_Filter["Value"].ToString())) 
            {

                query += "AND CAST(Value AS FLOAT) <= @Value ";
            }
            if (!string.IsNullOrWhiteSpace(Package_Filter["ReasonValue"].ToString())) query += "AND Reason = @PackageValue_3 ";
            if (!string.IsNullOrWhiteSpace(Package_Filter["StartTime"].ToString())) query += "AND Time >= @PackageValue_4 ";
            if (!string.IsNullOrWhiteSpace(Package_Filter["EndTime"].ToString())) query += "AND (Time_End <= @PackageValue_5 or Time_End is NULL)";
            if ((Package_Filter["Commit_TimeStamp"].ToString() == "true")){

                query += "AND (Commit_TimeStamp is not null )";
            } else if ((Package_Filter["Commit_TimeStamp"].ToString() == "false"))
                query += "AND (Commit_TimeStamp is null )";

            if (IsActiveAlarmTable) query += " AND (Status = 'OnGoing' OR Status = 'Monitor') ";

            query += " ORDER BY ID DESC OFFSET @StartIndex ROWS FETCH NEXT @RowCount ROWS ONLY;";

            // Create parameter placeholders for the IN clause based on the number of values in valueList
            string parameterNames = string.Join(",", valueList.Select((s, i) => $"@SelectedValue_{i}"));

            // Modify the query with the parameter placeholders
            query = string.Format(query, parameterNames);

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Add Parameter base on on TagName and  Filter 

                for (int i = 0; i < valueList.Count; i++)   
                {
                    
                    string parameterName = "@SelectedValue_" + i;
                    cmd.Parameters.AddWithValue(parameterName, valueList[i]);
                }

                
                if (Package_Filter.ContainsKey("ID") && !string.IsNullOrWhiteSpace(Package_Filter["ID"].ToString()))
                {
                    cmd.Parameters.AddWithValue("@ID", Package_Filter["ID"].ToString());
                }
               
                if (Package_Filter.ContainsKey("Value") && !string.IsNullOrWhiteSpace(Package_Filter["Value"].ToString()))
                {
                    cmd.Parameters.AddWithValue("@Value", float.Parse(Package_Filter["Value"].ToString())); // Assuming Value is a float
                }
                if (Package_Filter.ContainsKey("ReasonValue") && !string.IsNullOrWhiteSpace(Package_Filter["ReasonValue"].ToString()))
                {
                    cmd.Parameters.AddWithValue("@PackageValue_3", Package_Filter["ReasonValue"].ToString());
                }
                if (Package_Filter.ContainsKey("StartTime") && !string.IsNullOrWhiteSpace(Package_Filter["StartTime"].ToString()))
                {
                    cmd.Parameters.AddWithValue("@PackageValue_4", DateTime.Parse(Package_Filter["StartTime"].ToString())); // Assuming StartTime is a DateTime
                }
                if (Package_Filter.ContainsKey("EndTime") && !string.IsNullOrWhiteSpace(Package_Filter["EndTime"].ToString()))
                {
                    cmd.Parameters.AddWithValue("@PackageValue_5", DateTime.Parse(Package_Filter["EndTime"].ToString())); // Assuming EndTime is a DateTime
                }
                cmd.Parameters.AddWithValue("@StartIndex", startIndex);
                cmd.Parameters.AddWithValue("@RowCount", rowCount);


                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var data = new List<object>();

                    while (reader.Read())
                    {
                        string Label_TagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["TagDesc"] as string + ".Text") as string;
                        string Label_Reason = HttpContext.GetLocalResourceObject("~/Alarm.aspx", reader["Reason"] as string + ".Text") as string;

                        data.Add(new
                        {
                            ID = reader["ID"],
                            Label = Label_TagDesc,
                            Value = reader["Value"],
                            Standard = reader["PFC_Threshold"],
                            Time = reader["Time"],
                            Time_End = reader["Time_End"],
                            Status = reader["Status"],
                            Max_Temp = reader["Max_Temp"],
                            Line = reader["Line"],
                            Type = reader["Type"],
                            Reason = Label_Reason,
                            Comment = reader["Comment"],
                            Key = reader["TagDesc"],
                            Time_Commit = reader["Commit_TimeStamp"]
                        });
                    }

                    return data;
                }
            }
        }
    }

    // Load Data From PFC 
    public Dictionary<string, List<object>> LoadDataPara(string textSearch, bool searchByID, string factoryArea, string location , string line)
    {
        Dictionary<string, List<object>> packageData = new Dictionary<string, List<object>>();

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            string query = "SELECT PFCTable.*, TagMapping.Line, TagMapping.FactoryArea, TagMapping.Location, TagMapping.MachineID FROM dbo.PFCTable" +
                "  INNER JOIN dbo.TagMapping ON PFCTable.TagName = TagMapping.TagName" +
                " WHERE TagMapping.FactoryArea = @FactoryArea AND TagMapping.Location = @Location AND TagMapping.Line = @Line";


            if (searchByID)
            {
                query += " AND EXISTS (SELECT 1 FROM dbo.AlarmTable WHERE ID = @TextSearch AND TagDesc = PFCTable.TagDesc)";
            }
            else if (textSearch != "All")
            {
                query += " AND PFCTable.TagDesc = @TextSearch";
            }

            query += " ORDER BY PFCTable.TagName ASC";

            con.Open();

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@FactoryArea", factoryArea);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@Line", line);

                if (textSearch != "All")
                {
                    cmd.Parameters.AddWithValue("@TextSearch", textSearch);
                }

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        string currentMachine = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["Machine"] + ".Text") as string;
                        string labelTagDesc = HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader["TagDesc"] as string + ".Text") as string;

                        string positionMachine = reader["FactoryArea"] + "-" + reader["Location"] + "-" + reader["Line"];
                        string keyMachine = currentMachine + "-" + positionMachine;

                        if (!packageData.ContainsKey(keyMachine))
                        {
                            packageData[keyMachine] = new List<object>();
                        }

                        packageData[keyMachine].Add(new
                        {
                            TagDesc = labelTagDesc,
                            PFC_High = reader["PFC_High"],
                            PFC_Low = reader["PFC_Low"],
                            Active_HighOffset = reader["Active_HighOffset"],
                            Active_LowOffset = reader["Active_LowOffset"],
                            ID = reader["ID"],
                            Key = reader["TagDesc"],
                            Location = reader["Location"],
                            FactoryArea = reader["FactoryArea"],
                            MachineID = reader["MachineID"],
                            Machinelabel = currentMachine,
                            MachineType = reader["Machine"],
                            Line = reader["Line"]
                        });
                    }
                }
            }
        }

        return packageData;
    }



    // Update Data From PFC (1 TagName per times )
    public bool UpdateDataPara(string DatabaseName, string[] KeyName, string[] ValuebyKey, string[] KeyCondition, string[] ValueCondition)
    {
        // Load out TagName relate to the 

        List<object> data = LoadoutDatabase("dbo.TagMapping", new string[] { "TagName" }, KeyCondition, ValueCondition);

        // Process the returned data to extract TagName values
        List<string> tagNameList = new List<string>();

        foreach (var row in data)
        {
            if (row is List<object> rowData)
            {
                foreach (var item in rowData)
                {
                    if (item is string tagName)
                    {
                        tagNameList.Add(tagName);
                    }
                }
            }
        }

        // Convert List<string> to string[]
        string[] TagName = tagNameList.ToArray();

        UpdateInDatabase(DatabaseName, KeyName, ValuebyKey, new string[] { "TagName" }, TagName);

        return true;
    }


    // Update Data To Database  

    public void UpdateInDatabase(string DatabaseName, string[] KeyName, string[] ValuebyKey , string[] KeyCondition, string[] ValueCondition)
    {
        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            // Start building the query
            StringBuilder queryBuilder = new StringBuilder("UPDATE " + DatabaseName + " SET ");

            // Add each key-value pair to the query
            for (int i = 0; i < KeyName.Length; i++)
            {
                queryBuilder.Append(KeyName[i] + " = @" + KeyName[i]);
                if (i < KeyName.Length - 1)
                    queryBuilder.Append(", ");
            }
           // Add Key and Value for Condition // 
            if (KeyCondition.Length > 0)
            {
                queryBuilder.Append(" Where ");
                for (int i = 0; i < KeyCondition.Length; i++)
                {
                    queryBuilder.Append(KeyCondition[i] + " = @" + KeyCondition[i]);
                    if (i < KeyCondition.Length - 1)
                        queryBuilder.Append(" AND ");
                }
            }
            

            using (SqlCommand command = new SqlCommand(queryBuilder.ToString(), con))
            {
                // Add the parameters for each key-value pair
                for (int i = 0; i < KeyName.Length; i++)
                {
                    command.Parameters.AddWithValue("@" + KeyName[i], ValuebyKey[i]);
                }
                // Add the parameters for each key-value pair Condition
                for (int i = 0; i < KeyCondition.Length; i++)
                {
                    command.Parameters.AddWithValue("@" + KeyCondition[i], ValueCondition[i]);
                }
                

                con.Open();
                command.ExecuteNonQuery();
                con.Close();
            }
        }
    }

    // Load out Data by Key Name and condition 

    public static List<object> LoadoutDatabase(string DatabaseName, string[] KeyName, string[] KeyCondition, string[] ValueCondition)
    {
        List<object> dataList = new List<object>();

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            StringBuilder queryBuilder = new StringBuilder("SELECT DISTINCT ");

            if (KeyName.Length > 0)
            {
                for (int i = 0; i < KeyName.Length; i++)
                {
                    queryBuilder.Append(KeyName[i]);
                    if (i < KeyName.Length - 1)
                    {
                        queryBuilder.Append(",");
                    }
                }
            }
            queryBuilder.Append(" FROM " + DatabaseName);

            // Check if KeyCondition and ValueCondition are both null
            if (KeyCondition != null && ValueCondition != null && KeyCondition.Length > 0 && ValueCondition.Length > 0)
            {
                queryBuilder.Append(" WHERE ");
                for (int i = 0; i < KeyCondition.Length; i++)
                {
                    queryBuilder.Append(KeyCondition[i] + " = @" + KeyCondition[i]);
                    if (i < KeyCondition.Length - 1)
                        queryBuilder.Append(" AND ");
                }
            }

            using (SqlCommand command = new SqlCommand(queryBuilder.ToString(), con))
            {
                if (KeyCondition != null && ValueCondition != null && KeyCondition.Length > 0 && ValueCondition.Length > 0)
                {
                    for (int i = 0; i < KeyCondition.Length; i++)
                    {
                        command.Parameters.AddWithValue("@" + KeyCondition[i], ValueCondition[i]);
                    }
                }

                con.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    List<object> rowData = new List<object>();

                    for (int i = 0; i < KeyName.Length; i++)
                    {
                        string Value_LocalResource = (HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader[KeyName[i]].ToString() + ".Text") as string) == null ? reader[KeyName[i]].ToString() : (HttpContext.GetLocalResourceObject("~/HistoryData.aspx", reader[KeyName[i]].ToString() + ".Text") as string);

                        rowData.Add(Value_LocalResource); // Assuming you want to add string values
                    }

                    dataList.Add(rowData);
                }

                reader.Close();
            }
        }

        return dataList;
    }


    public List<object> LoadTimeWork()
    {
        var data = new List<object>();

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            con.Open();
            string query = "SELECT TOP 1 StartWorkTime ,StartBreakTime, EndBreakTime ,EndWorkTime FROM dbo.WorkTime;";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var database = new DataTable();
                    database.Load(reader);
                    foreach (DataRow row in database.Rows)
                    {
                        data.Add(new
                        {
                            StartWorkTime = row["StartWorkTime"],
                            StartBreakTime = row["StartBreakTime"],
                            EndBreakTime = row["EndBreakTime"],
                            EndWorkTime = row["EndWorkTime"],
                        });
                    }
                    con.Close();
                    return data;
                }
            }
        }
    }



    public List<object> LoadStatusPFC( string[] KeyCondition, string[] ValueCondition)
    {
        List<object> packageData = new List<object>();

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            StringBuilder queryBuilder = new StringBuilder();
            queryBuilder.Append("SELECT DISTINCT PFCTable.EnableAlarm, TagMapping.MachineID, TagMapping.MachineType ");
            queryBuilder.Append("FROM dbo.PFCTable ");
            queryBuilder.Append("JOIN dbo.TagMapping ON PFCTable.TagName = TagMapping.TagName ");

            // add condition in Query

            if (KeyCondition != null && ValueCondition != null && KeyCondition.Length > 0 && ValueCondition.Length > 0)
            {
                queryBuilder.Append("WHERE ");
                for (int i = 0; i < KeyCondition.Length; i++)
                {
                   
                        queryBuilder.Append("TagMapping." + KeyCondition[i] + " = @" + KeyCondition[i]);
                        if (i < KeyCondition.Length - 1)
                        {
                            queryBuilder.Append(" AND ");
                        }
                   
                }
            }

            con.Open();

            using (SqlCommand cmd = new SqlCommand(queryBuilder.ToString(), con))
            {
                // Add value for Condition
                if (KeyCondition != null && ValueCondition != null && KeyCondition.Length > 0 && ValueCondition.Length > 0)
                {
                    for (int i = 0; i < KeyCondition.Length; i++)
                    {
                        cmd.Parameters.AddWithValue("@" + KeyCondition[i], ValueCondition[i]);
                    }
                }

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        List<object> data = new List<object>
                         {
                            reader["MachineID"].ToString(),
                            reader["EnableAlarm"].ToString(),
                            reader["MachineType"].ToString()
                        };

                        packageData.Add(data);
                    }
                }
            }
        }

        return packageData;
    }



    public bool UpdateStatusPFC( string[] keyName, string[] valuebyKey, string[] keyCondition, string[] valueCondition)
    {
        if (keyName.Length != valuebyKey.Length || keyCondition.Length != valueCondition.Length)
        {
            throw new ArgumentException("The lengths of keyName, valuebyKey, keyCondition, and valueCondition must match.");
        }

        using (SqlConnection con = new SqlConnection(_connectionString))
        {
            StringBuilder queryBuilder = new StringBuilder();

            // Construct the UPDATE query
            queryBuilder.Append("UPDATE dbo.PFCTable SET ");
            for (int i = 0; i < keyName.Length; i++)
            {
                queryBuilder.Append(keyName[i] + " = @" + keyName[i]);
                if (i < keyName.Length - 1)
                {
                    queryBuilder.Append(", ");
                }
            }

            // Add JOIN clause
            queryBuilder.Append(" FROM dbo.PFCTable ");
            queryBuilder.Append(" JOIN dbo.TagMapping ON PFCTable.TagName = TagMapping.TagName ");

            // Add WHERE conditions
            if (keyCondition != null && valueCondition != null && keyCondition.Length > 0 && valueCondition.Length > 0)
            {
                queryBuilder.Append(" WHERE ");
                for (int i = 0; i < keyCondition.Length; i++)
                {
                    queryBuilder.Append("TagMapping." + keyCondition[i] + " = @" + keyCondition[i]);
                    if (i < keyCondition.Length - 1)
                    {
                        queryBuilder.Append(" AND ");
                    }
                }
            }

            string query = queryBuilder.ToString();

            con.Open();
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Add parameters for the values to be updated
                for (int i = 0; i < keyName.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + keyName[i], valuebyKey[i]);
                }

                // Add parameters for the conditions
                for (int i = 0; i < keyCondition.Length; i++)
                {
                    cmd.Parameters.AddWithValue("@" + keyCondition[i], valueCondition[i]);
                }

                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0;
            }
        }
    }


    public DataTable PFCTableSelectAll(
           string TagName
       )
    {
        DBNull dbNULL = DBNull.Value;
        using (SqlConnection scon = new SqlConnection(_connectionString))
        {
            try
            {
                var dt = new DataTable(); 
                var cmd = new SqlCommand("usp_PFC_SelectAll", scon);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TagName", string.IsNullOrEmpty(TagName) ? dbNULL : (object)TagName);

                SqlParameter errorCodeParam = new SqlParameter("@ErrorCode", null);
                errorCodeParam.Size = 4;
                errorCodeParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(errorCodeParam);
                var sda = new SqlDataAdapter(cmd);
                sda.Fill(dt);

                if (errorCodeParam.Value.ToString() != "0")
                    throw new Exception("Stored Procedure 'usp_PFC_SelectAll' reported the ErrorCode : " + errorCodeParam.Value.ToString());

                return dt;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }


}