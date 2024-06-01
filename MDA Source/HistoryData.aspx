
<%@ Page Title="HistoryData" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistoryData.aspx.cs" Inherits="MDA_CTP.HistoryData"   %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
   
    <!-- Function - Search -->
 

<script src="https://kit.fontawesome.com/2767141d82.js" crossorigin="anonymous"></script>
    <head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>


    <div>



        <div class="jumbotron">
            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="Factory" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Factory" meta:resourceKey="Factory">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-industry" style="font-size: 28px; margin-right: 5px;"></i>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Height="28px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Width="200px" Style="margin-right: 20px;">

                        <asp:ListItem Text="SelectedFactory" meta:resourceKey="SelectedFactory" Value="" />
                    </asp:DropDownList>

                </div>
            </div>

            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="Line" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Line" meta:resourceKey="Line">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-users-line" style="font-size: 28px; margin-right: 5px;"></i>
                    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" Height="28px" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Width="200px" Style="margin-right: 20px;">
                        <asp:ListItem Text="SelectedFactory" meta:resourceKey="SelectedFactory" Value="" />

                    </asp:DropDownList>
                </div>
            </div>

            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="Machine" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Machine" meta:resourceKey="Machine">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-gear" style="font-size: 28px; margin-right: 5px;"></i>
                    <select id="Multiple1" multiple name="native-select" data-search="false" data-silent-initial-value-set="true" style="height: 20px; width: 200px; margin-right: 20px;"></select>
                </div>
            </div>

            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="TagName" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Tag Name" meta:resourceKey="TagName">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-database" style="font-size: 28px; margin-right: 5px; margin-left: 20px;"></i>
                    <select id="Multiple2" multiple name="native-select" data-search="false" data-silent-initial-value-set="true" style="height: 28px; width: 200px; margin-right: 20px;"></select>
                </div>
            </div>



            <input id="Input-Multiple1" type="hidden" />

            <input id="Input-Multiple2" type="hidden" />



            <input id="Inputbt" type="hidden" runat="server" />


            <asp:HiddenField ID="HiddenField1" runat="server" />

            <asp:HiddenField ID="Placeholder_Machine_text" runat="server" Value="" />

            <asp:HiddenField ID="Lable_Machine_Tag" runat="server" Value="" />


            <asp:HiddenField ID="Placeholder_Data_text" runat="server" Value="" />

            <asp:HiddenField ID="Data_TagName_Receive" runat="server" />



        </div>


        <div class="name">


            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="StartDate" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="StartDate" meta:resourceKey="StartDate">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-calendar-days" style="font-size: 28px; margin-right: 5px; height: 28px; width: 35px; margin-left: 20px;"></i>

                    <input type="datetime-local" id="StartTime" name="meeting-time" style="font-size: 15px; margin-right: 20px; height: 28px; width: 200px;">
                </div>
            </div>

            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="EndDate" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="EndDate" meta:resourceKey="EndDate">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-solid fa-calendar-days" style="font-size: 28px; margin-right: 5px; height: 28px; width: 35px"></i>
                    <input type="datetime-local" id="EndTime" name="meeting-time" style="font-size: 15px; margin-right: 20px; height: 28px; width: 200px;" lang="auto">
                </div>
            </div>


            <div style="display: flex; flex-direction: column; align-items: center;">
                <asp:Label ID="Period" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Period" meta:resourceKey="Period">  </asp:Label>
                <div style="display: flex; align-items: center;">
                    <i class="fa-regular fa-clock" style="font-size: 28px; margin-right: 5px;"></i>
                    <select id="DropDownList8" name="cycle" style="font-size: 15px; margin-right: 5px; height: 20px; width: 200px; margin-right: 20px; height: 28px;">
                        <option value="" selected>
                            <asp:Label ID="SelectedPeriod" runat="server" Text="Period" meta:resourceKey="SelectedPeriod">  </asp:Label></option>
                        <option value="1">
                            <asp:Label ID="Period1p" runat="server" Text="Period" meta:resourceKey="Option_Period_1p">  </asp:Label>
                        </option>
                        <option value="5">
                            <asp:Label ID="Label1" runat="server" Text="Period" meta:resourceKey="Option_Period_5p"> </asp:Label>
                        </option>
                        <option value="10">
                            <asp:Label ID="Period10p" runat="server" Text="Period" meta:resourceKey="Option_Period_10p">  </asp:Label>
                        </option>
                        <option value="15">
                            <asp:Label ID="Period15p" runat="server" Text="Period" meta:resourceKey="Option_Period_15p">  </asp:Label>
                        </option>
                        <option value="30">
                            <asp:Label ID="Period30p" runat="server" Text="Period" meta:resourceKey="Option_Period_30p">  </asp:Label>
                        </option>
                        <option value="45">
                            <asp:Label ID="Period45p" runat="server" Text="Period" meta:resourceKey="Option_Period_45p">  </asp:Label>
                        </option>
                        <option value="60">
                            <asp:Label ID="Period60p" runat="server" Text="Period" meta:resourceKey="Option_Period_60p">  </asp:Label>
                        </option>
                        <option value="1440">
                            <asp:Label ID="Period1D" runat="server" Text="Period" meta:resourceKey="Option_Period_1d">  </asp:Label>
                        </option>

                    </select>
                </div>
            </div>
            <!--
        <button type="button" id="SerchButton" class="btn btn-primary" onclick="submitForm()"style="margin-right : 10px;">
            <i class="fa-solid fa-gavel" ></i>
            Biểu đồ
        </button> 

        -->



            <button type="button" id="downloadButton" class="btn btn-primary" onclick="downloadExcel()" style="margin-right: 10px;">
                <i class="fa fa-download"></i>
                <asp:Label ID="Report" runat="server" Text="Report" meta:resourceKey="Report">  </asp:Label>
            </button>






        </div>


    </div>

    <!-- Buttons and chart container -->
    <div class="tag_box" style="width: 1500px;">
        <ul>
            <li id="homeItem" onclick="handleClick('homeItem')">
                <a>
                    <span>
                        <asp:Label ID="Average" runat="server" Text="AverageData" meta:resourceKey="AverageData"> </asp:Label>
                    </span>
                    <i id="home" class="fas fa-spinner fa-spin"></i>
                </a>
            </li>

            <li id="Realdata" onclick="handleClick('Realdata')">
                <a>
                    <span>
                        <asp:Label ID="RealTime" runat="server" Text="RealData" meta:resourceKey="RealData"> </asp:Label></span>
                    <i id="realtime" class="fas fa-spinner fa-spin"></i>
                </a>
            </li>

        </ul>
    </div>




    <!--</div>-->
    <div class="Garph-decord">




        <!-- Highcharts container -->
        <figure class="highcharts-figure">
            <div id="container" class="container-overflow" data-highcharts-chart="0" aria-hidden="false" role="region" aria-label="Chart. Highcharts interactive chart.">
                <!-- Your chart content here -->
            </div>
        </figure>




    </div>

    <div id="dataContainer"></div>


    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/boost.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/series-label.js"></script>
    <script src="https://code.highcharts.com/modules/exporting.js"></script>
    <script src="https://code.highcharts.com/modules/export-data.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>
    <script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
    <link rel="stylesheet" href="../Dist/virtual-select.min.css">
    <link href="Dist/Style_History.css" rel="stylesheet" />
    <script src="../Dist/virtual-select.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


    <!-- Script for Set and Update Multiple Drop List Data  -->

    <script>

        $(document).ready(function () {

            var isMultiple2Initialized = false; // Flag to track initialization
            var Multiple2 = $('#Multiple2');
            // Get the placeholder name //

            var Placeholder_Machine = document.getElementById('<%= Placeholder_Machine_text.ClientID %>').value;

            var Placeholder_Data = document.getElementById('<%= Placeholder_Data_text.ClientID %>').value;

            // Function to populate options in 'Multiple1' dropdown

            function VirtualSelect_Init(Name_key) {

                VirtualSelect.init({
                    ele: "#"+Name_key,
                    multiple: true,
                    placeholder: (Name_key == "Multiple1") ? Placeholder_Machine : Placeholder_Data
                });


            }

            function destroyVirtualSelection2() {
                document.querySelector('#Multiple2').destroy();
                select2 = $('#Multiple2');
                //initializeVirtualSelection2();  
            }

            // Function to initialize Virtual Selection for Multiple2
            function initializeVirtualSelection2() {
                select2 = $('#Multiple2');
                VirtualSelect.init({
                    ele: '#Multiple2',
                    multiple: true,
                    placeholder: Placeholder_Machine
                });
                isMultiple2Initialized = true; // Update flag to indicate initialization
            }


            // Initial population of 'Multiple1' dropdown on document ready
           
            VirtualSelect_Init("Multiple1");  // Init Multiple 1 
            VirtualSelect_Init("Multiple2");  // Init Multiple 2 
         
         
            var Data_TagName_Receive = document.getElementById('<%= Data_TagName_Receive.ClientID %>').value; // Get Tag Name From C# //  
            var Data_TagName_Populate = JSON.parse(Data_TagName_Receive);
            Data_TagName_Populate = Data_TagName_Populate.map(item => ({ label: item.Label, value: item.Value }));

            // Set Option for Multiple 1 //

            document.querySelector('#Multiple1').reset();
            document.querySelector('#Multiple1').setOptions(Data_TagName_Populate);

            // Multiple 1 change event //  
            $('#Multiple1').on('change', function () {
                var Data_TagName_Get = $(this).val();
                $('#Input-Multiple1').val(Data_TagName_Get);

                // Get data from all Droplist // 
                var Data_TagName = $('#Input-Multiple1').val();
                var Data_Factory = document.getElementById('<%= DropDownList1.ClientID %>').value;
                var Data_Line = document.getElementById('<%= DropDownList2.ClientID %>').value;
               
                // call Ajax back to C# //   
                $.ajax({
                    type: "POST",
                    url: "HistoryData.aspx/LoadData_TagDesc",
                    data: JSON.stringify({ Machine_Value: Data_TagName, Location_Value: Data_Factory, Line_Value: Data_Line }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_TagDesc_Receive) {

                        Multiple2.empty(); //  Empty Multiple 2
                        var _Data_TagDesc_Receive = JSON.parse(Data_TagDesc_Receive.d);
                        if (_Data_TagDesc_Receive.length != 0) {
                            if (isMultiple2Initialized) {
                                destroyVirtualSelection2(); // Destroy Multiple2 if value from Multiple1 changed
                            }
                            // Set option for Multiple 2 

                            initializeVirtualSelection2();
                            _Data_TagDesc_Receive = _Data_TagDesc_Receive.map(item => ({ label: item.Label, value: item.Value }));
                            document.querySelector('#Multiple2').reset();
                            document.querySelector('#Multiple2').setOptions(_Data_TagDesc_Receive);


                        }
                        else {
                            // reset a new one if the Multiple 1 is null //  
                            destroyVirtualSelection2();
                            initializeVirtualSelection2();
                        }

                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                });

            });


        });

    </script>
 
    <!-- Fucntion to load and process chart -->

    <script>

        var flagcheck = false;
        var TimeCycle_Min = 0;
        var previous = 0;
        var Last_Mode = null;
        var chart = Highcharts.chart('container', {

            exporting: {

                buttonOptions: {
                    width: 100,
                    height: 80,
                    symbolSize: 14,
                    symbolX: 30,
                    symbolY: 30,
                    symbolStrokeWidth: 2,
                    symbolStroke: '#666',
                    style: {
                        fontSize: '1px',
                        fontFamily: 'Arial, sans-serif'
                    }
                }
            },

            plotOptions: {
                line: {
                    lineWidth: 1 // Set the line width
                }
            },

            title: {
                text: '',

                style: {
                    fontSize: '20px',
                    fontWeight: 'bold',
                    align: 'left'
                }
            },

            chart: {
                type: 'line',
                animation: Highcharts.svg,
                zoomType: 'x',
                panning: true,
                panKey: 'shift',
                resetZoomButton: {
                    theme: {
                        style: {
                            fontSize: '14px',
                            fontWeight: 'bold',
                            fontFamily: 'Arial, sans-serif',
                            color: '#a94442',
                            backgroundColor: '#333333'
                        }
                    }
                }

            },
            tooltip: {
                valueDecimals: 2,
                style: {
                    fontSize: '14px',
                    fontFamily: 'Arial, sans-serif'
                }

            },
            xAxis: {
                type: 'datetime',

                title: {
                    style: {
                        fontSize: '25px'
                    }
                },
                scrollbars : true

            },
            yAxis: {
                title: {
                   
                    style: {
                        fontSize: '16px'
                    }
                }
            },
            series: [{
                data: [],
                lineWidth: 0.5,
                
                connectNulls: false

            }],
            legend: {
                itemStyle: {
                    fontFamily: 'Arial',
                    fontSize: '14px',
                    fontWeight: 'bold',
                    color: 'blue'
                },
            }

        });
        var previous_Flag = false;
        var Data_download = [
            { tagName: "", intervalStart: "", average: "" },


        ];
        var series = chart.series[0];   // Variable to store the series instance
        var interval = null; // Variable to store the interval ID
        var index_submit = 0;
        var Update_Chart_Option = {

            chart: {
                type: 'line',
                animation: Highcharts.svg,
                zoomType: 'x',
                panning: true,
                panKey: 'shift',
                resetZoomButton: {
                    theme: {
                        style: {
                            fontSize: '14px',
                            fontWeight: 'bold',
                            fontFamily: 'Arial, sans-serif',
                            color: '#a94442',
                            backgroundColor: '#333333'
                        }
                    }
                }

            },

            title: {
                text: '',

                style: {
                    fontSize: '25px',
                    fontWeight: 'bold',
                    align: 'left'
                }
            },
            xAxis: {
                type: 'datetime',
                labels: {
                    formatter: function () {
                        var date = new Date(this.value);

                        var day = date.toLocaleString("en-US", { day: 'numeric' });
                        var mounth = date.toLocaleString("en-US", { mounth: 'numeric' });

                        var hour = date.toLocaleString("en-US", { hour: 'numeric', hour12: true });


                        if (previous == (day + " " + hour)) {
                            return "";
                        }
                        previous = day + " " + hour;
                        return mounth;

                    }
                }
            },
            yAxis: {
                min: 0,
                

               
            },
            tooltip: {
                formatter: function () {
                    // Disable default tooltip content

                    var date = new Date(this.x);
                    return date.toLocaleString("en-US", { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: true })
                        + " Value: " + this.y + " " + this.series.name;
                },
                style: {
                    fontSize: '16px',

                    align: 'left'
                },
                pointFormatter: function () {

                }
            },
            legend: {

                itemStyle: {
                    fontFamily: 'Arial',
                    fontSize: '14px',
                    color: 'blue'
                }
            }
        };
        var _Data_Receive = [];
        var _SubData_Receive = [];
        var icon_last = 0;
        var splitCharts = [];
        var splitContainers = []; // Declare and initialize the splitContainers array
        var chartOptions = 0;
        var isSplit = false;

        // Process Data into each chart  //

        function Make_Send_Text(KeyMode) {

            if (KeyMode == "Average") {  
                flagcheck = false;
                if ($('#DropDownList8').val() == "") {

                    Submit_RealTime_Detail(0);
                    return;
                }
            }

            var startTime = document.getElementById('StartTime').value;
            var endTime = document.getElementById('EndTime').value;

            var [Date_start, time_start] = startTime.split('T');
            var [Date_end, time_end] = endTime.split('T');

            var dateStart = Date_start + " " + time_start + ":00";
            var dateEnd = Date_end + " " + time_end + ":00";

            var Input_Cycle = $('#DropDownList8').val();
            var TagDesc = $('#Multiple2').val();
            if (Input_Cycle < TimeCycle_Min) TimeCycle_Min = Input_Cycle;

            return (Input_Cycle + "," + dateStart + "," + dateEnd + "," + TagDesc);
        }

        function processChartData(data) {
            const _data = Object.assign({}, ...data);
            return Object.fromEntries(
                Object.entries(_data).map(([key, value]) => [key, removeDuplicates(value, 'IntervalStart')])
            );
        }

        function createChart(containerId, seriesName, data,  Unit) {
            const signalOptions = {
                chart: {
                    type: 'line',
                    renderTo: containerId,
                },
                series: [{
                    lineWidth: 0.5,
                    name: seriesName,
                    data: data,
                    connectNulls: false,
                }],
                yAxis: {
                    title: {
                        text: Unit,
                        style: {
                            fontSize: '13px',
                            fontWeight: 'bold'
                        }
                    }
   
                }

            };

            return new Highcharts.Chart(signalOptions);
        }

        function processDataForDownload( intervalStartArray, averageArray, TagDesc) {
            function formatDate(date) {
                const options = {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: 'numeric',
                    minute: 'numeric',
                    hour12: true
                };
                return date.toLocaleDateString('en-US', options);
            }

            for (let i = 0; i < averageArray.length; i++) {
                if (!isNaN(averageArray[i]) && !isNaN(intervalStartArray[i])) {
                    Data_download.push({
                        intervalStart: formatDate(new Date(intervalStartArray[i])),
                        average: averageArray[i],
                        TagDesc: TagDesc,
                    });
                }
            }
        }

        function processChildChart(data) {
            const Data_Receive = processChartData(data);
            Data_download = [];  
            const container = document.getElementById('container');
            container.style.overflow = ''; // Remove the 'hidden' value
            container.innerHTML = '';

            
            let Chart_index = 0;
            for (const [tagName, dataList] of Object.entries(Data_Receive)) {
                const containerId = `container${Chart_index++}`;
                const newContainer = document.createElement('div');
                newContainer.id = containerId;
                newContainer.style.overflow = 'auto';
                container.appendChild(newContainer);
                const lastEntry = dataList[dataList.length - 1];
                var TagDesc = lastEntry[0][0]; // Accessing the first element of the last entry
                const Unit = lastEntry[0][1]; // Accessing the second element of the last entry
                const TypeData = lastEntry[0][2];

                var titleChart = TypeData + " - " + Unit; 

                const mapDataProperty = prop => dataList.map(item => item[prop]);
                const intervalStartArray = mapDataProperty('IntervalStart').map(date => new Date(date).getTime());
                const averageArray = mapDataProperty('Average').map(parseFloat);
               /* const TagDesc = mapDataProperty('TagDesc');*/
                const data_chart = intervalStartArray.map((timestamp, index) => [timestamp, averageArray[index]]);
             

                const splitChart = createChart(containerId, TagDesc, data_chart, titleChart);
                splitChart.update(Update_Chart_Option);
                splitCharts.push(splitChart);

                processDataForDownload( intervalStartArray, averageArray, TagDesc);
            }
            
            chart.redraw();
        }

        function removeDuplicates(arr, prop) {
            const unique = {};
            const result = [];

            for (const item of arr) {
                //console.log(item[prop]); 
                if (!unique[item[prop]]) {
                    result.push(item);
                    unique[item[prop]] = true;
                }
            }

            return result;
        }

        function removeEmptyItems(arr, prop) {
            return arr.filter(item => item[prop] && item[prop].trim() !== "");
        }


        function Get_data_chunk(chunkData) {
            // push data to each label data //  
           
            for (let tag in chunkData) {
                let obj = {};
                obj[tag] = chunkData[tag];

                let found = false;
                for (let i = 0; i < _Data_Receive.length; i++) {
                    if (_Data_Receive[i].hasOwnProperty(tag)) {

                        if (Array.isArray(_Data_Receive[i][tag])) {
                            _Data_Receive[i][tag].push(...chunkData[tag]); // If it's an array, push the data
                        } else {
                            _Data_Receive[i][tag] = [_Data_Receive[i][tag], chunkData[tag]]; // Convert to array and add the data
                        }
                        found = true;
                        break;
                    }
                }
                if (!found) {

                    _Data_Receive.push(obj); //  

                }
            }
        }

        function resetChart() {
            // Check if the chart exists and has series
            if (chart && chart.series && chart.series.length > 0) {
                // Clear xAxis categories
                chart.xAxis[0].setCategories([], false);

                // Remove all series from the chart
                while (chart.series.length > 0) {
                    chart.series[0].remove(false);
                }

                // Redraw the chart
                chart.redraw();
            }
        }

        // Function to Load chart data

        // get the avergage data
        async function submitForm_detail() {

            return new Promise(function (resolve, reject) {
                var graphSection = document.querySelector('.Garph-decord');
                if (graphSection) {
                    graphSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }

                var Data_send_Average = Make_Send_Text("average"); 
                  
                $.ajax({
                    type: "POST",
                    url: "HistoryData.aspx/Load_Data_Average",
                    data: JSON.stringify({ values: Data_send_Average, chunkIndex: index_submit }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_Receive) {
                        var chunkData = JSON.parse(Data_Receive.d);

                        
                        function isObjectEmpty(obj) {
                            return Object.keys(obj).length === 0 && obj.constructor === Object;
                        }
                        
                        if (!isObjectEmpty(chunkData)) {
                            index_submit++; // Increment index
                            Get_data_chunk(chunkData);  
                            submitForm_detail();
                        }
                        else {
                           console.log(_Data_Receive);
                            processChildChart(_Data_Receive);  
                            hideLoadingIcon(icon_last);
                            resolve();
                            

                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(error); // Reject the promise in case of an error
                    }
                });
            });

            
        }


        async function Submit_RealTime_Detail() {
            return new Promise(function (resolve, reject) {
                
                var Data_send_Realtime = Make_Send_Text("RealTime");
                
                //console.log(datasend_TagDesc);
                $.ajax({
                    type: "POST",
                    url: "HistoryData.aspx/Load_Data_RealTime",
                    data: JSON.stringify({ values: Data_send_Realtime, chunkIndex: index_submit }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_Receive) {                       
                        var chunkData = JSON.parse(Data_Receive.d);
                        function isObjectEmpty(obj) {
                            return Object.keys(obj).length === 0 && obj.constructor === Object;
                        }
                        if (!isObjectEmpty(chunkData)) {                          
                            index_submit++; // Increment index
                            Get_data_chunk(chunkData);                          
                            Submit_RealTime_Detail();
                        }
                        else {
                            processChildChart(_Data_Receive);
                            hideLoadingIcon(icon_last);
                            resolve();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(error); // Reject the promise in case of an error
                    }
                });

            });


        }

        // get  the real time data
        async function downloadExcel() {
           
            try {
               
                if (Last_Mode == 'homeItem') {

                    var newinterEnd = [];
                    var Input_Cycle = $('#DropDownList8').val();
                    // Process Tag Desc //
                    for (let i = 0; i < Data_download.length; i++) {
                        var originalDateTime = new Date(Data_download[i].intervalStart);

                        // Check if the originalDateTime is a valid date
                        if (!isNaN(originalDateTime.getTime())) {
                            // Add 5 minutes (5 * 60 * 1000 milliseconds) to the originalDateTime
                            originalDateTime.setTime(originalDateTime.getTime() + Input_Cycle * 60 * 1000);

                            // Subtract 1 second from the updated date
                            originalDateTime.setSeconds(originalDateTime.getSeconds() - 1);

                            // Store the formatted date string in the newinterEnd array
                            newinterEnd.push({ endaTime: formatDate(originalDateTime) });
                        } else {
                           
                          
                            newinterEnd.push(null); // For example, push null for an invalid date
                        }
                    }
                    function formatDate(date) {
                        const options = {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: 'numeric',
                            minute: 'numeric',
                            hour12: true
                        };
                        return date.toLocaleDateString('en-US', options);
                    }

                   
                    var IntervalEndArray = [];
                    for (var i = 0; i < newinterEnd.length; i++) {
                        var [datePart, timePart] = newinterEnd[i].endaTime.split(", ");
                        var [hour, round] = timePart.split(" ");

                        IntervalEndArray.push({ endaTime: datePart + " " + hour + ":59 " + round });

                    }

                    // Modify Data_download to include the endaTime values
                    for (let i = 0; i < Data_download.length; i++) {
                        Data_download[i].endaTime = (IntervalEndArray[i] && IntervalEndArray[i].endaTime) || null;
                    }
                    var workbook = XLSX.utils.book_new();
                    var dataForSheet = Data_download.map(item => [item.TagDesc, item.intervalStart, item.endaTime, item.average]);
                    var worksheet = XLSX.utils.aoa_to_sheet([['Tag Desc', 'Interval Start', 'Interval End', 'Average']].concat(dataForSheet));
                }
                else {
                   
                    //await Submit_RealTime_Detail(0);
                    var workbook = XLSX.utils.book_new();
                    var dataForSheet = Data_download.map(item => [item.TagDesc, item.intervalStart, item.average]);
                    var worksheet = XLSX.utils.aoa_to_sheet([['Tag Desc', 'Interval Start', 'Average']].concat(dataForSheet));

                }




                XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');
                var excelFile = XLSX.write(workbook, { bookType: 'xlsx', type: 'binary' });

                var s2ab = function (s) {
                    var buf = new ArrayBuffer(s.length);
                    var view = new Uint8Array(buf);
                    for (var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
                    return buf;
                };

                var blob = new Blob([s2ab(excelFile)], { type: 'application/octet-stream' });

                var startTime = document.getElementById('StartTime').value;
                var endTime = document.getElementById('EndTime').value;
                var [Date_start, time_start] = startTime.split('T');
                var [Date_end, time_end] = endTime.split('T');
                var NameReport = 'Report_' + Date_start + '_' + Date_end;

                var downloadLink = document.createElement('a');
                downloadLink.href = URL.createObjectURL(blob);
                downloadLink.download = NameReport + '.xlsx';
                downloadLink.click();
            } catch (error) {
                console.error(error); // Handle errors if needed
            }
        }

        // Function to handle button clicks

        function handleClick(item) {

            // clear chart data
            resetChart();
            Highcharts.charts = [];

            // Active the Style
            var TagSelect = document.querySelectorAll('.tag_box li');
            for (var i = 0; i < TagSelect.length; i++) {
                TagSelect[i].classList.remove('active');
            }
            Last_Mode = item;

            if (Last_Mode == 'homeItem') {

                icon_last = 'home';

            }
            else {
                icon_last = 'realtime';
            }

            document.getElementById(item).classList.add('active');

            if (item == 'homeItem') {
                hideLoadingIcon('realtime');
                LoadingIcon('home');
            }
            else if (item == 'Realdata') {

                hideLoadingIcon('home');
                LoadingIcon('realtime');
            }

            
            // Load data into chart   
            _Data_Receive = [];
            index_submit = 0;
            if (item === 'homeItem') {
                submitForm_detail();
            }
            else if (item === 'Realdata') {
                Submit_RealTime_Detail();
            }

        }

        function hideLoadingIcon(id) {
            var loadingIcon = document.getElementById(id);
            if (loadingIcon) {
                loadingIcon.style.display = 'none'; // Hide the loading icon
            }
        }

        function LoadingIcon(id) {
            var loadingIcon = document.getElementById(id);
            if (loadingIcon) {
                loadingIcon.style.display = 'inline-block'; // Hide the loading icon
            }
        }

    

    </script>


    

</asp:Content>
