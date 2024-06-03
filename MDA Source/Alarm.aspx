<%@ Page Title="Alarm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Alarm.aspx.cs" Inherits="MDA_CTP.Alarm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <head>
        <link rel="stylesheet" href="../Dist/virtual-select.min.css">
        <script src="../Dist/virtual-select.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <%--<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>--%>


        <link href="Dist/Style_Alarm.css" rel="stylesheet" />
        <script src="https://kit.fontawesome.com/2767141d82.js" crossorigin="anonymous"></script>


        <script src="https://code.highcharts.com/highcharts.js"></script>
        <script src="https://code.highcharts.com/modules/series-label.js"></script>
        <script src="https://code.highcharts.com/modules/exporting.js"></script>
        <script src="https://code.highcharts.com/modules/export-data.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
         <script src="https://code.highcharts.com/modules/stock.js"></script>
        <!-- More scripts -->



    </head>


    <div>

        <div class="jumbotron">
            <div class="row" >
                <div class="Item" style="display: flex; flex-direction: column; align-items: center;">
                    <asp:Label ID="Factory" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Factory_Text" meta:resourceKey="Factory">  </asp:Label>
                    <div style="display: flex; align-items: center;">
                        <i class="fa-solid fa-industry" style="font-size: 28px; margin-right: 5px;"></i>

                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" Height="28px" Width="180px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" Style="margin-right: 10px;" class="icon-dropdown">

                            <asp:ListItem Text="SelectedFactory" meta:resourceKey="SelectedFactory" Value="" />
                        </asp:DropDownList>

                    </div>
                </div>

                <div class="Item" style="display: flex; flex-direction: column; align-items: center;">
                    <asp:Label ID="Line" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Line" meta:resourceKey="Line">  </asp:Label>
                    <div style="display: flex; align-items: center;">
                        <i class="fa-solid fa-users-line" style="font-size: 28px; margin-right: 5px;"></i>
                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" Height="28px" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Width="180px" Style="margin-right: 10px;">
                            <asp:ListItem Text="SelectedFactory" meta:resourceKey="SelectedFactory" Value="" />

                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="Item" style="display: flex; flex-direction: column; align-items: center; margin-right: 10px;">
                    <asp:Label ID="Machine" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Machine" meta:resourceKey="Machine">  </asp:Label>
                    <div style="display: flex; align-items: center;">
                        <i class="fa-solid fa-gear" style="font-size: 28px; margin-right: 5px;"></i>
                        <select id="Multiple1" multiple name="native-select" data-search="false" data-silent-initial-value-set="true" style="height: 20px; width: 100px; margin-right: 5px;"></select>
                    </div>
                </div>

                <div class="Item" style="display: flex; flex-direction: column; align-items: center; margin-right: 10px;">
                    <asp:Label ID="TagName" runat="server" Style="font-weight: bold; margin-right: 10px;" Text="Tag Name" meta:resourceKey="TagName">  </asp:Label>
                    <div style="display: flex; align-items: center;">
                        <i class="fa-solid fa-database" style="font-size: 28px; margin-right: 5px;"></i>
                        <select id="Multiple2" multiple name="native-select" data-search="false" data-silent-initial-value-set="true" style="height: 28px; width: 100px; margin-right: 5px;"></select>
                    </div>
                </div>

            </div>
        </div>

        <!-- field stored the value  -->

        <asp:HiddenField ID="StoredAddress" runat="server" />

        <asp:HiddenField ID="StoredParameter" runat="server" />

        <asp:HiddenField ID="StoredTagInf" runat="server" />

        <asp:HiddenField ID="Error" runat="server" Value="" />

        <asp:HiddenField ID="PlaceHolderMultiple1" runat="server" />

        <asp:HiddenField ID="PlaceHolderMultiple2" runat="server" />

        <div class="TagSelected">
            <ul>

                <li id="ActiveAlarm" onclick="handleClick('ActiveAlarm')">
                    <a >
                        <span>  
                            <asp:Label ID="Label5" runat="server" Text="ActiveAlarm" meta:resourceKey="ActiveAlarm"> </asp:Label></span>

                    </a>
                </li>

                <li id="AlarmRecord_Tag" onclick="handleClick('AlarmRecord_Tag')">
                    <a>
                        <span>
                            <asp:Label ID="AlarmRecord" runat="server" Text="AlarmRecord" meta:resourceKey="AlarmRecord"> </asp:Label>
                        </span>

                    </a>
                </li>

                <li id="SetPFC_Tag" onclick="handleClick('SetPFC_Tag')">
                    <a >
                        <span>
                            <asp:Label ID="SetPFC" runat="server" Text="SetPFC" meta:resourceKey="SetPFC"> </asp:Label></span>

                    </a>
                </li>

            </ul>
        </div>

        <audio id="notificationSound" autoplay>
            <source src="../Sound/AlarmSound.mp3" type="audio/mpeg">

            <source src="../Sound/AlarmSound.mp3" type="audio/mpeg">

            <asp:HiddenField ID="Hidden_Sound" runat="server" Value="" />

        </audio>

        <!-- containner for table Alarm Record -->
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div id ="modal-content" class="modal-content">

                <div class="Action">

                    <div class="Zoom">

                        <i class="fas fa-expand-alt" id="zoomIcon"></i>


                    </div>

                    <div class="close" id ="CloseIcon" >
                         <i class="fas fa-times"></i>

                    </div>


                </div>


                <div class="Layout">
                     
                    <div id ="Inf_Setup" class ="Inf_Setup">

                        <div class="modal-Infor1">

                            
                            <p><strong><asp:Label runat="server" Text="Description" meta:resourceKey="Description"></asp:Label></strong> 
                                <span id="Description_Modal"></span></p>
                            <div class ="Infor-Sub" style="display:block">

                                <p><strong><asp:Label runat="server" Text="ID" meta:resourceKey="ID"></asp:Label>
                                    </strong><span id="ID_Modal"></span></p>
                                <p><strong><asp:Label runat="server" Text="Value" meta:resourceKey="Value"></asp:Label></strong>
                                    <span id="Value_Modal"></span></p>


                                <p><strong><asp:Label runat="server" Text="Line" meta:resourceKey="Line"></asp:Label> </strong>
                                    <span id="Line_Modal"></span></p>
                               


                            </div>

                            <div class="form-group">
                                <label for="dropdown_Modal"><strong><asp:Label runat="server" Text="Reason" meta:resourceKey="Reason"></asp:Label></strong></label>
                                <select id="dropdown_Modal" class="form-control">
                                    <option value="Machine error">
                                        <asp:Label runat="server" Text="Error1_confirm" meta:resourceKey="Error1_confirm"></asp:Label>
                                    </option>
                                    <option value="Change the shoe mold">
                                        <asp:Label runat="server" Text="Error2_confirm" meta:resourceKey="Error2_confirm"></asp:Label></option>
                                    <option value="Data error">
                                        <asp:Label runat="server" Text="Error4_confirm" meta:resourceKey="Error4_confirm"></asp:Label></option>
                       
                                    <option value="Operational error">
                                        <asp:Label runat="server" Text="Error6_confirm" meta:resourceKey="Error6_confirm"></asp:Label></option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="Text_Modal"><strong><asp:Label runat="server" Text="Comment" meta:resourceKey="Comment"></asp:Label></strong></label>
                                <input type="text" id="Text_Modal" class="form-control" />
                            </div>



                        </div>

                        <div class="SetUp" style="display: block;">
                            <div id="colorBar" class="color-bar">
                                <!-- Lines at specific percentages -->
                                <div class="marker" style="left: 12.5%;"></div>
                                <div class="marker" style="left: 37.5%;"></div>
                                <div class="marker" style="left: 62.5%;"></div>
                                <div class="marker" style="left: 87.5%;"></div>
                            </div>

                            <!-- Tag  to show out the numbers -->
                            <div class="value-inputs">
                                <input type="text" id="LowOffset_Modal" readonly  onchange="UpdateChart('LowOffset_Modal', 'Red' ,'triangle-down')" />
                                <input type="text" id="LowThreshold_Modal" readonly  onchange="UpdateChart('LowThreshold_Modal', 'Green','triangle-down')" />
                                <input type="text" id="HighThreshold_Modal" readonly  onchange="UpdateChart('HighThreshold_Modal', 'Green','triangle')" />
                                <input type="text" id="HighOffset_Modal" readonly  onchange="UpdateChart('HighOffset_Modal', 'Red','triangle')" />
                            </div>

                            <!-- Tag  to modify the numbers -->

                            
                            <div id ="ChangeID" class="slider-container" style="display:none">
                                
                                <strong><asp:Label runat="server" Text="Value" meta:resourceKey="Value"></asp:Label>
                                </strong>


                                <div id="Minus_Value" class="ChangeComponent" onclick="UpdateThreshold('-1')">
                                    <i class="fa-solid fa-minus fa-xs"></i>
                                </div>


                                <div class="slider-value" id="sliderValue">
                                    <input type="text" id="ValueThreshold" onchange="ChangeByInputLevel()" />
                                </div>

                                <div id="Plus_Value" class="ChangeComponent" onclick="UpdateThreshold('+1')">
                                    <i class="fa-solid fa-plus fa-xs"></i>
                                </div>

                            </div>

                        </div>

                        <div id="ButtonConfirm" style="display: flex; justify-content: space-between; flex-direction: column;">
                            <button type="button" id="submitButton" class="btn btn-primary" onclick="ConfirmAlarm()" style="margin-top: 20px;">
                                <asp:Label runat="server" Text="Submit" meta:resourceKey="submit"></asp:Label>

                            </button>
                            <button type="button" id="SetStandardID" class="btn btn-primary" onclick="Extend_SetStandard()" style="margin-top: 20px;">
                                <asp:Label runat="server" Text="Standard" meta:resourceKey="Standard"></asp:Label>

                            </button>
                        </div>

                    </div>  

                    
                    <asp:HiddenField ID="StoredID_Database" runat="server" />

                    <asp:HiddenField ID="languageField" runat="server" />
                   
                    <asp:HiddenField ID="Level_Active"  runat="server" />

                     <div class="modal-Graph" style="display: none">

                            <div id ="calendar"  align-items: center;">
                                <!-- Icon for displaying the calendar -->
                               
                                <!-- Input for displaying the date -->
                                <input type="datetime-local" id="SelectedTimePopUp" name="meeting-time" style="font-size: 15px; margin-right: 10px; height: 28px; width: 200px; display: block;" lang="auto">
                                <div id="AjustDay">
                                    <!-- Icon for decreasing the date -->
                                    <i id="decreaseDate" class="fa-solid fa-chevron-left" style="font-size: 16px;  height: 33px; width: 35px; cursor: pointer;"></i>
                                    <!-- Icon for increasing the date -->
                                    <i id="increaseDate" class="fa-solid fa-chevron-right" style="font-size: 16px; height: 33px; width: 35px; cursor: pointer;"></i>

                                </div>
                               
                                <div class="ButtonScale">

                                    <button class="button" id="Scale15p" onclick="toggleFunction('Scale15p', event)">15m</button>
                                    <button class="button" id="Scale30p" onclick="toggleFunction('Scale30p', event)">30m</button>
                                    <button class="button" id="Scale1h" onclick="toggleFunction('Scale1h', event)">1h</button>
                                    <button class="button" id="Scale4h" onclick="toggleFunction('Scale4h', event)">4h</button>
                                    <button class="button" id="Scale1d" onclick="toggleFunction('Scale1d', event)">1d</button>

                                </div>
                                <div id="ButtonTimeNow">

                                    <button class="button" id="GetNow" onclick="SwitchtodayNow(event)">Now</button>
                                </div>

                            </div>
                            <figure class="highcharts-figure">
                                <div id="container" class="container-overflow" data-highcharts-chart="0" aria-hidden="false" role="region" aria-label="Chart. Highcharts interactive chart.">
                                    <!-- Your chart content here -->
                                </div>
                            </figure>

                        </div>

                </div>

               

                

            </div>

           


        </div>

        <div id="Table_Alarm" class="Table_Alarm" style="display: block">


            <asp:Table ID="Table_Field" runat="server" BorderColor="Black">
                <asp:TableRow ID="Field_Fix">
                    <asp:TableCell ID="IDCell" Text="ID" meta:resourceKey="ID" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="TagName" meta:resourceKey="TagName" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Line" meta:resourceKey="Line" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Value" meta:resourceKey="Value" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Standard Machine" meta:resourceKey="Standard" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Time_Start" meta:resourceKey="TimeStart" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Time_End" meta:resourceKey="TimeEnd" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Time_Commit" meta:resourceKey="TimeCommit" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Reason" meta:resourceKey="Reason" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Comment" meta:resourceKey="Comment" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                </asp:TableRow>

                <asp:TableRow ID="Field_Search">
                    <asp:TableCell> <input id="ID" type="text" style="width:auto"/>  </asp:TableCell>
                    <asp:TableCell><input id="Tag" type="text" /></asp:TableCell>
                    <asp:TableCell><input id="Line_Search" type="text" /></asp:TableCell>
                    <asp:TableCell><input id="Value" type="text"/></asp:TableCell>
                    <asp:TableCell><input id="Standard_input" type="text" /></asp:TableCell>
                    <asp:TableCell><input type="datetime-local" id="StartTime" name="meeting-time"style="font-size: 15px;"lang="auto"> </asp:TableCell>
                    <asp:TableCell><input type="datetime-local" id="EndTime" name="meeting-time"style="font-size: 15px;"lang="auto"> </asp:TableCell>
                    <asp:TableCell>
                        <select id="Commit_Search" class="form-control" style="border-radius:10px">
                            <option value="" selected>
                                <asp:Label runat="server" Text="All" meta:resourceKey="All" ></asp:Label>
                            </option>
                            <option value="true">
                                <asp:Label runat="server" Text="Commit" meta:resourceKey="Commit"></asp:Label>
                            </option>
                            <option value="false">
                                <asp:Label runat="server" Text="Uncommit" meta:resourceKey="Uncommit"></asp:Label></option>
                            
                        </select>

                    </asp:TableCell>

                    <asp:TableCell>

                        <select id="Reason_Search" class="form-control" style="border-radius:10px">
                            <option value="" selected >
                                <asp:Label runat="server" Text="All" meta:resourceKey="All"></asp:Label>
                            </option>
                            <option value="Machine error">
                                <asp:Label runat="server" Text="Error1_confirm" meta:resourceKey="Error1_confirm"></asp:Label>
                            </option>
                            <option value="Change the shoe mold">
                                <asp:Label runat="server" Text="Error2_confirm" meta:resourceKey="Error2_confirm"></asp:Label></option>
                            <option value="Data error">
                                <asp:Label runat="server" Text="Error4_confirm" meta:resourceKey="Error4_confirm"></asp:Label></option>
                            <option value="Operational error">
                                <asp:Label runat="server" Text="Error6_confirm" meta:resourceKey="Error6_confirm"></asp:Label></option>
                        </select>

                      </asp:TableCell>

                    <asp:TableCell> 
                      <button type="button" id="Mute" class="btn btn-primary" style="margin-right: 10px;" text="Sound" onclick="stopCustomSound()"> 
                          <i  class="fa-solid fa-volume-xmark"></i>

                      </button>

                    </asp:TableCell>
                </asp:TableRow>




            </asp:Table>
            <asp:Table ID="Table_content" runat="server" BorderColor="Black">
            </asp:Table>




        </div>


        <div id="Set_Parameter" style="display: none">
            <div id="MachineName" class="navbar-vertical navbar" >

                <div class="nav-item">
                    <div class="nav-item-content">
                        <div class="nav-link" data-bs-toggle="collapse" id="SetUpAlarm" onclick="toggleOptions('OptionPara')">

                            <asp:Label ID="TitleTagSetup" runat="server" Text="Alarm Parameter" meta:resourceKey="AlarmParameter"> </asp:Label>
                            
                        </div>
                        <button  type="button" class="btn btn-lg btn-toggle" data-toggle="button" aria-pressed="false" autocomplete="off">
                            <div class="handle"></div>
                        </button>
                    </div>


                    <div class="options collapse " id="OptionPara">
                        

                        <div class="containerSetup">

                            <div id="TimeStampSetUp">
                                <div class="ListPara" style="flex-direction: row; align-items: center; margin-top: 10px">
                                    <asp:Label ID="StartDate" runat="server" Style="" Text="StartDate" meta:resourceKey="StartDate"></asp:Label>
                                    <input type="time" id="Start_TimeStampSetUp" name="meeting-time" style="font-size: 15px; width: 15vh; height: 28px;">
                                </div>
                                <div class="ListPara" style="flex-direction: row; align-items: center; margin-top: 10px">
                                    <asp:Label ID="Label1" runat="server" Style="" Text="Start Break Time" meta:resourceKey="StartBreakTime"></asp:Label>
                                    <input type="time" id="StartBreak_TimeStampSetUp" name="meeting-time" style="font-size: 15px; width: 15vh; height: 28px;">
                                </div>
                                <div class="ListPara" style="flex-direction: row; align-items: center; margin-top: 10px">
                                    <asp:Label ID="Label2" runat="server" Style="" Text="End Break Time" meta:resourceKey="EndBreakTime"></asp:Label>
                                    <input type="time" id="EndBreak_TimeStampSetUp" name="meeting-time" style="font-size: 15px; width: 15vh; height: 28px;">
                                </div>



                                <div class="ListPara" style="flex-direction: row; align-items: center; margin-top: 10px">
                                    <asp:Label ID="EndDate" runat="server" Style="" Text="EndDate" meta:resourceKey="EndDate"></asp:Label>
                                    <input type="time" id="End_TimeStampSetUp" name="meeting-time" style="font-size: 15px; height: 28px; width: 15vh;" lang="auto">
                                </div>

                            </div>

                            <div id="ActionSetup">
                                <button type="button" id="ButtonSetup" class="btn btn-primary" onclick="UpdatePFCSetUp()" style="margin-top: 20px;">
                                    <asp:Label runat="server" Text="Submit" meta:resourceKey="submit"></asp:Label>
                                </button>

                            </div>


                        </div>





                    </div>


                </div>



            </div>
            
           
        </div>


        <div id="Table_Alarm_Active" class="Table_Alarm" style="display: none">


            <asp:Table ID="Table2" runat="server" BorderColor="Black">
                <asp:TableRow>
                    <asp:TableCell Text="ID" meta:resourceKey="ID" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="TagName" meta:resourceKey="TagName" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Line" meta:resourceKey="Line" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Value" meta:resourceKey="Value" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Standard Machine" meta:resourceKey="Standard" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Time_Start" meta:resourceKey="TimeStart" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Time_Commit" meta:resourceKey="TimeCommit" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                    <asp:TableCell Text="Reason" meta:resourceKey="Reason" Style="text-transform: uppercase; font-weight: bold;"></asp:TableCell>
                </asp:TableRow>
                
                <asp:TableRow >
                    <asp:TableCell> <input id="IDActive" type="text" style="width:auto"/>  </asp:TableCell>
                    <asp:TableCell><input id="TagActive" type="text" /></asp:TableCell>
                    <asp:TableCell><input id="Line_SearchActive" type="text" /></asp:TableCell>
                    <asp:TableCell><input id="ValueActive" type="text"ư /></asp:TableCell>
                    <asp:TableCell><input id="Standard_inputActive" type="text" /></asp:TableCell>
                    <asp:TableCell><input type="datetime-local" id="StartTimeActive" name="meeting-time"style="font-size: 15px;"lang="auto"> </asp:TableCell>
                    <asp:TableCell><input type="datetime-local" id="CommitTimeActive" name="meeting-time"style="font-size: 15px;"lang="auto"> </asp:TableCell>
                    <asp:TableCell>
                        <button type="button" id="MuteActive" class="btn btn-primary" style="margin-right: 10px;" onclick="stopCustomSound()" > 
                            <i id="Ring" class="fa-solid fa-volume-xmark"></i>
                        </button>

                    </asp:TableCell>
                </asp:TableRow>

            </asp:Table>
            <asp:Table ID="Table_content_active" runat="server" BorderColor="Black">
            </asp:Table>

            

        </div>


    </div>




    <!-- Function base on the Component  -->

    <script>

       
        
       
        var Package_DataPara, Package_DataAlarm;
        var fetchIntervalId;
        Highcharts.setOptions({
            lang: {
                
                rangeSelectorZoom: '' 
            }
        });

        // define  chart //
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
                    lineWidth: 2 // Set the line width
                }

            },

            title: {
                text: '',

                style: {
                    fontSize: '16px',
                    fontWeight: 'bold',
                    align: 'left'
                }
            },

            chart: {
                type: 'line',
                
                zoomType: 'x',
                panning: true,
                panKey: 'shift',
                resetZoomButton: {
                    theme: {
                        style: {
                            fontSize: '16px',
                            fontWeight: 'bold',
                            fontFamily: 'Arial, sans-serif',
                            color: '#a94442',
                            backgroundColor: '#333333'
                        }
                    }
                },
                

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
                        fontSize: '16px'
                    }
                }
            },
            yAxis: {
                
                title: {
                    text: '',
                    style: {
                        fontSize: '15px',
                        fontWeight: 'bold'
                    }
                },
                labels: {
                    style: {
                        fontSize: '13px' // Set the font size for y-axis labels
                    }
                }
                
            },
            
            legend: {
                itemStyle: {
                    fontFamily: 'Arial',
                    fontSize: '16px',
                    fontWeight: 'bold',
                    color: 'blue'
                }
            },
           

            
           

        });  

        var Update_Chart_Option = {
            plotOptions: {
                series: {
                    states: {
                        inactive: {
                            enabled: false  // disable the animation changing background // 
                        }
                    }

                }
            },

            xAxis: {
                tickPositioner: function () {
                    var positions = [],
                        twoHourInterval = 8 * 60 * 60 * 1000, // 2 hours in milliseconds
                        minTime = this.dataMin,
                        maxTime = this.dataMax;

                    for (var time = minTime; time <= maxTime; time += twoHourInterval) {
                        positions.push(time);
                    }

                    return positions;
                },
                labels: {
                    formatter: function () {
                        var date = new Date(this.value);
                        const options = {
                            month: '2-digit',
                            day: '2-digit',
                            year: 'numeric',
                            hour: 'numeric',
                            minute: 'numeric',
                            second: 'numeric',
                            hour12: true
                        };

                        var formattedDate = date.toLocaleDateString('en-US', options);
                        
                        return formattedDate;
                    },
                    style: {
                        fontSize: '12px',
                        whiteSpace: 'wrap'
                    }
                },
                crosshair: {
                    width: 1,
                    

                }
               
            },
            tooltip: {
                formatter: function () {
                    var date = new Date(this.x);
                    return date.toLocaleString("en-US", { year: 'numeric', month: 'numeric', day: 'numeric', hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: true }) ;
                },
                style: {
                    fontSize: '15px',
                    align: 'left'
                },
                pointFormatter: function () {

                }
            },
            yAxis: {
                crosshair: {
                    width: 1, 
                    label: {
                        enabled: true, 
                        style: { "color": "white", "fontWeight": "normal", "fontSize": "15px", "textAlign": "center" }
                    }
                   
                }, 

                labels: {
                    formatter: function () {
                        return this.value.toFixed(1);
                    }
                }, 
                min :0 
            }, 
           


        };


        // Function to start fetching data based on the mode
        function startFetching(mode) {
            // Clear any existing interval
            clearInterval(fetchIntervalId);

            // Choose the appropriate function and interval duration based on the mode
            if (mode === 'data') {
                LoadDataAlarm(true, 'ActiveAlarm');
                fetchIntervalId = setInterval(function () {
                    //TrackIDNewItem();
                    FetchNewData();
                }, 2000);
            } else if (mode === 'id') {
                LoadDataAlarm(false, 'AlarmRecord');
                fetchIntervalId = setInterval(function () {
                    FetchNewData();

                }, 5000);
            } else if (mode = "setup") {

                const Factory = sessionStorage.getItem('_FactoryResponsibility');
                const Location = sessionStorage.getItem('_LocationResponsibility');
                const Line = sessionStorage.getItem('_LineResponsibility');

                LoadDisableAlarm(null, Factory, Location, Line);
               
                fetchIntervalId = setInterval(function () {
                    FetchNewData();
                    LoadDisableAlarm(null, Factory, Location, Line);
                }, 5000);

            }else {
               
                console.error('Invalid mode specified.');
            }
        }
        // Show Tag selected

        function handleClick(id) {

            var items = document.querySelectorAll('.TagSelected li');
            items.forEach(function (item) {
                item.classList.remove('active');
            });

            var selectedItem = document.getElementById(id);
            selectedItem.classList.add('active');
           

            

            // Show the appropriate container based on the clicked tag
            if (id === 'AlarmRecord_Tag') {
                
                $('#<%= Table_content.ClientID%>').empty();
                
                document.getElementById('Table_Alarm').style.display = 'block';
                document.getElementById('Set_Parameter').style.display = 'none';
                document.getElementById('Table_Alarm_Active').style.display = 'none';

                startFetching('id');
            } else if (id === 'SetPFC_Tag') {
               
                document.getElementById('Set_Parameter').style.display = 'flex';
                document.getElementById('Table_Alarm').style.display = 'none';
                document.getElementById('Table_Alarm_Active').style.display = 'none';
                LoadDisableAlarm(null, "VH", "S2" , "1");
                startFetching('setup');
            } else if (id === 'ActiveAlarm') {

                $('#<%= Table_content_active.ClientID%>').empty();
                document.getElementById('Table_Alarm').style.display = 'none';
                document.getElementById('Set_Parameter').style.display = 'none';
                document.getElementById('Table_Alarm_Active').style.display = 'block';
              
                startFetching('data');
            }
            
            
            sessionStorage.setItem('_TagCurrentAlarm', id); // 'true'
        }

        // Update Alarm data to Table
        function updateTable(data, NameTable) {
            
            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');
            var StartIndex = $('#MainContent_Table_content tr').length;
            if (StartIndex == 0) {

                $('#<%= Table_content.ClientID%>').empty();
                $('#<%= Table_content_active.ClientID%>').empty();

            }
            if (TagActive == 'ActiveAlarm') {

                $('#<%= Table_content_active.ClientID%>').empty();
            }

            
            var lengthMainTable = $('#MainContent_Table_content tr').length;
            if ((lengthMainTable > 0) && (NameTable === 'AlarmRecord')) {
                Package_DataAlarm.push(data);

            } else {

                Package_DataAlarm = data;

            }

            // Stored Data data Package in  
            // Populate the table with the updated data
            $.each(data, function (index, item) {
                // Create a new row
                var row = $("<tr></tr>");
                // Set the class and onclick attribute of the row
                row.attr("class", "selectable-row");
               
               
                // Create an icon and attach a click event to it
                var icon = $("<i class='fa-solid fa-wrench'></i>"); // Replace 'icon-class' with the actual class of your icon
                
                icon.on('click', function (e) {
                    e.stopPropagation(); // Prevent the row's click event from being triggered
                    
                    openPopUpSession(); 
                    // Get all the cells in the row

                    document.querySelector('.SetUp').style.display = 'none';
                    document.querySelector('.modal-Graph').style.display = 'none';
                    document.querySelector('.Infor-Sub').style.display = 'block';
                    var calendar = document.getElementById("SelectedTimePopUp"); //  calander in chart PopUp
                    //// Fill data in the PopUp 
    
                    document.getElementById('ID_Modal').textContent = item.ID;
                    document.getElementById('Description_Modal').textContent = item.Label;
                    document.getElementById('Value_Modal').textContent = item.Value;
                    document.getElementById('Line_Modal').textContent = item.Line;
                    var dropdown = document.getElementById('dropdown_Modal');
                    for (var i = 0; i < dropdown.options.length; i++) {
                        
                        if (dropdown.options[i].value === item.Reason) {
                            
                            dropdown.selectedIndex = i;
                            break;
                        }
                    }
                    document.getElementById('Text_Modal').value = item.Comment;

                    // Update TimeStamp

                    calendar.value = toLocalISOString(new Date(formatDate(item.Time)));

                    $('.close').on('click', function () {

                        closePopUpSession();
                        // Hide the Modal 
                        $('#myModal').css('display', 'none');
                       
                    });

                    var modalContent = document.querySelector('.modal-content');
                    modalContent.classList.toggle('full-width', false);


                    // Show the modal
                    $('#myModal').css('display', 'block');
                    

                    
                });

                // Add the icon next to the ID
                var idCell = $("<td></td>");


                idCell.append(item.ID);
                idCell.append(icon);
                icon.attr("id", item.ID);
                row.append(idCell);

                if (NameTable === 'AlarmRecord') {
                    
                    // Create and append the cells to the row
                    row.append("<td>" + item.Label + "</td>");
                    row.append("<td>" + item.Line + "</td>");
                    row.append("<td>" + item.Value + "</td>");
                    row.append("<td>" + item.Standard + "</td>");
                    row.append("<td>" + formatDate(item.Time) + "</td>");
                    row.append("<td>" + ((item.Time_End == null) ? "<i class='fa-solid fa-ellipsis'></i>" : formatDate(item.Time_End)) + "</td>");
                    row.append("<td>" + ((item.Time_Commit == null) ? "<i class='fa-solid fa-ellipsis'></i>" : formatDate(item.Time_Commit)) + "</td>");
                    row.append("<td>" + item.Reason + "</td>");
                    row.append("<td>" + ((item.Comment == null) ? "<i class='fa-solid fa-ellipsis'></i>" : item.Comment) + "</td>");
                }
                else {
                    
                    // Create and append the cells to the row
                    row.append("<td>" + item.Label + "</td>");
                    row.append("<td>" + item.Line + "</td>");
                    row.append("<td>" + item.Value + "</td>");
                    row.append("<td>" + item.Standard + "</td>");
                    row.append("<td>" + formatDate(item.Time) + "</td>");
                    row.append("<td>" + ((item.Time_Commit == null) ? "<i class='fa-solid fa-ellipsis'></i>" : formatDate(item.Time_Commit)) + "</td>");
                    row.append("<td>" + item.Reason + "</td>");
                }
                // Append the row to the table

                if (item.Status === "OnGoing") {
                    if (item.Type === "Alarm")
                        row.css("background-color", "#ff6e6e");
                    else
                        row.css("background-color", "#f7894b");
                }
                else if (item.Status === "EndAlarm") {
                    row.css("background-color", "#ffffff");
                }
                else if (item.Status === "Monitor") {

                    row.css("background-color", "#7fffff ");

                }

                
                if (NameTable =='AlarmRecord')
                    $('#<%=  ( Table_content.ClientID) %>').append(row);
                else
                    $('#<%=  ( Table_content_active.ClientID) %>').append(row);
            });





            function formatDate(dateString) {
                const timestamp = parseInt(dateString.replace("/Date(", "").replace(")/", ""));
                const date = new Date(timestamp);
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
        }   

        function LoadDataAlarm(IsActiveAlarm, NameTable) {
            var StartIndex;  
            if (IsActiveAlarm == false)
                StartIndex = $('#MainContent_Table_content tr').length;
            else
                StartIndex = 0;
            $.ajax({
                type: "POST",
                url: "Alarm.aspx/LoadDataAlarm",
                data: JSON.stringify({ IsActiveAlarmTable: IsActiveAlarm, StartIndex: StartIndex, RowCount: 100, PackageData: Make_Package_Send(NameTable) }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_Receive) {
                    // update Alarm Table 
                    updateTable(JSON.parse(Data_Receive.d), NameTable );
                   

                },
                error: function (xhr, status, error) {
                    console.error(error);
                }

            });
        }

        // Make Json Object to Load Data ALarm 

        function Make_Package_Send(NameTable) {
            var StartID, EndId, Filler;

            if (NameTable == 'ActiveAlarm') {
                StartID = 'StartTimeActive';
                EndId = null;
                Filler = {
                    ID: $('#IDActive').val(),
                    Tag: $('#TagActive').val(),
                    Value: $('#ValueActive').val(),
                    Reason : '',
                    Commit: ''
                };
            } else {
                StartID = 'StartTime';
                EndId = 'EndTime';
                Filler = {
                    ID: $('#ID').val(),
                    Tag: $('#Tag').val(),
                    Value: $('#Value').val(),
                    Reason: $('#Reason_Search').val(),
                    Commit: $('#Commit_Search').val()
                };
            }

            var startTime = document.getElementById(StartID).value;
            var endTime = false;
            if (EndId !=null)
                endTime = document.getElementById(EndId).value;
            var dateStart = "", dateEnd = ""; 
            // Check if startTime and endTime are not empty
            if (!startTime || !endTime) {
                

                // return null;
            }
            if (startTime) {
                var [Date_start, time_start] = startTime.split('T');
                dateStart = Date_start + " " + time_start + ":00";
                
            }
            if (endTime) {
                var [Date_end, time_end] = endTime.split('T');
                dateEnd = Date_end + " " + time_end + ":00";
               

            }

           
            var TagDesc = $('#Multiple2').val();

            // Construct the result object
            var result = {
                ID: Filler.ID,
                Tag: Filler.Tag,
                Value: Filler.Value,
                ReasonValue: Filler.Reason,
                StartTime: dateStart,
                EndTime: dateEnd,
                TagDesc: TagDesc.toString(),
                Commit_TimeStamp: Filler.Commit
            };

            return result;
        }

        // Turn on  Sound
        function playCustomSound() {

            var notificationSound = document.getElementById("notificationSound");
            

            notificationSound.play();
            
        }
        // Turn off Sound
        function stopCustomSound() {

            const IsTurnSound = JSON.parse(sessionStorage.getItem('_EnableSound')) === true;

            if (IsTurnSound == true) {
                var notificationSound = document.getElementById("notificationSound");
                notificationSound.pause();
                notificationSound.currentTime = 0;
                sessionStorage.setItem('_EnableSound', JSON.stringify(false));
            }

        }

        // Fetch New data
        function FetchNewData() {

            
            // Get the uniqueId from sessionStorage
            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');
            var uniqueId = sessionStorage.getItem('IdUser');
            $.ajax({
                type: "POST",
                url: "Alarm.aspx/CheckNewItem",
                contentType: "application/json; charset=utf-8",
                data: JSON.stringify({ uniqueId: uniqueId }),
                dataType: "json",
                success: function (response) {
                    var IsTurnSound = JSON.parse(sessionStorage.getItem('_EnableSound')) === true;
                    var result = JSON.parse(response.d);
                    // Check for data changes and update table
                    if (result.IsDataChange) {
                        // check for Alarm table 
                        if (result.IsAlarmLevel) {
                            playCustomSound();
                            IsTurnSound= true;
                        }
                        // Load New Data
                        if ((TagActive != null)) {
                            handleClick(TagActive);
                        } else {
                            // Default Tag 
                            handleClick('AlarmRecord_Tag')
                        }
                    }

                    // Turn sound 
                    if (IsTurnSound) playCustomSound();  
                    sessionStorage.setItem('_EnableSound', JSON.stringify(IsTurnSound)); // 'true'
                    //console.log(result);
                    
                   
                },
                error: function (error) {
                    console.error('Error:', error);
                }   
            });
        }

        // Function Action in PopUp

        function ConfirmAlarm() {
            var packageSend = gatherPackageData();

            if (validateInput(packageSend)) {
                updateAlarmInDatabase(packageSend, sessionStorage.getItem('_ExtendFlag'));
                closePopUpSession();  

            } else {
                alert(document.getElementById('<%= Error.ClientID %>').value);

            }
        }

        // Function to load parameter level and adjust UI accordingly
        function Extend_SetStandard() {

            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');
            // adjust Display 
            const modalContent = document.querySelector('.modal-content');
            const modalGraph = document.querySelector('.modal-Graph');
            

            modalContent.classList.remove('full-width');
            modalGraph.classList.remove('full-width');

            //Get Data to Seacch  
            const ID_Selected = (TagActive !== 'SetPFC_Tag') ? document.getElementById('ID_Modal').textContent : document.getElementById('<%= StoredID_Database.ClientID %>').value;
            const _SearchByID = TagActive !== 'SetPFC_Tag';

            // Update time value in Chart PopUp
            var calendar = document.getElementById("SelectedTimePopUp");
            const ButtonNow = document.getElementById("GetNow");
            
            if (sessionStorage.getItem('_TagCurrentAlarm') === 'SetPFC_Tag') {

               
                updateTimestamp(240, calendar, true);
                // update css for the button 
                ButtonNow.classList.add('active');
                sessionStorage.setItem('_LoadCurrentTime', true);

            } else {

                updateTimestamp(120, calendar, false);
                ButtonNow.classList.remove('active');
                sessionStorage.setItem('_LoadCurrentTime', false)


            }
                

            // Loading PFC Data and Ajust Paramater 
            updateParameterLevel(ID_Selected, _SearchByID).then(handleParameterUpdate).catch(console.error);
        }

        // Function gather data to update data in Popup 

        function gatherPackageData() {
            var ID = document.getElementById('ID_Modal').textContent;
            var TagDesc_Target = document.getElementById('<%= StoredID_Database.ClientID %>').value;
            var Option = $('#dropdown_Modal').val();
            var Comment = $('#Text_Modal').val();
            var Low_Threshold = parseFloat($('#LowThreshold_Modal').val()) - parseFloat($('#LowOffset_Modal').val());
            var High_Threshold = parseFloat($('#HighOffset_Modal').val()) - parseFloat($('#HighThreshold_Modal').val());
            var Line = document.getElementById('Line_Modal').textContent;

            var packageSend = {
                ID: ID,
                Reason: Option,
                Comment: Comment,
                FactoryArea: Line.split("-")[0], 
                Location: Line.split("-")[1], 
                Line: Line.split("-")[2]

            };
            const extendFlag = JSON.parse(sessionStorage.getItem('_ExtendFlag')) === true;
            if (!(extendFlag)) {
                packageSend.HighThreshold = $('#HighThreshold_Modal').val();
                packageSend.LowThreshold = $('#LowThreshold_Modal').val();
                packageSend.High_Threshold_Calculated = High_Threshold;
                packageSend.Low_Threshold_Calculated = Low_Threshold;
                packageSend.TagDesc = TagDesc_Target;
            }

            return packageSend;
        }

        // Validate value PFC 
        function validateInput(packageSend) {

           
                

            const extendFlag = JSON.parse(sessionStorage.getItem('_ExtendFlag')) === true;
            if (!extendFlag) {
                var thresholds = [
                    packageSend.HighThreshold,
                    packageSend.LowThreshold,
                    packageSend.High_Threshold_Calculated,
                    packageSend.Low_Threshold_Calculated
                ];

                // Check it's null or Not number 

                for (var value of thresholds) {
                    if (value === '' || isNaN(value)) {
                        return false;
                    }
                }
                console.log(((parseFloat(packageSend.HighThreshold) < parseFloat(packageSend.LowThreshold))));
                // Check the logic threshold 
                if ((parseFloat(packageSend.HighThreshold) < parseFloat(packageSend.LowThreshold)) || (parseFloat(packageSend.High_Threshold_Calculated) < 0) || (parseFloat(packageSend.Low_Threshold_Calculated) < 0)) {
                    return false;

                }
                var _FormatNumberInput = JSON.parse(sessionStorage.getItem('_FormatNumber')) === true;

               
                if (!_FormatNumberInput) {

                    return false;
                }

            }
            return true;
        }

        function updateAlarmInDatabase(packageSend, isChangePFC) {
            $('#myModal').css('display', 'none');
            $.ajax({
                type: "POST",
                url: "Alarm.aspx/UpdateAlarmStatus",
                data: JSON.stringify({ packages: packageSend, isChangePFC: isChangePFC }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                async: false,
                success: function () {
                    handleRedirect();
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
            // Update Text in  PFC Tag 
            updateMachineName(packageSend.TagDesc);
        }

        // Redirect to Current Page  

        function handleRedirect() {

            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');

            if (TagActive === 'AlarmRecord_Tag') {
                handleClick('AlarmRecord_Tag');
            } else if (TagActive === 'ActiveAlarm') {
                handleClick('ActiveAlarm');
            }
        }

        // Handle the update of parameter levels
        function handleParameterUpdate() {
            
            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');
            const keyLabelElement = document.getElementById('Description_Modal');
            let keyLabel = keyLabelElement.textContent;

            if (TagActive !== 'SetPFC_Tag') {
                const matchingItem = Package_DataAlarm.find(item => item.ID.toString() === document.getElementById('ID_Modal').textContent);
                if (matchingItem) {
                    keyLabel = matchingItem.Key;
                }
            } else {
                keyLabel = document.getElementById('<%= StoredID_Database.ClientID %>').value;
            }
            // Adjust parameters based on key label
            for (const key in Package_DataPara) {
                if (Package_DataPara.hasOwnProperty(key)) {
                    const values = Package_DataPara[key];
                    const matchingValue = values.find(value => keyLabel === value.Key);
                    if (matchingValue) {
                        updateUIWithParameters(matchingValue);
                        sessionStorage.setItem('_ExtendFlag', JSON.stringify(false));
                        return;
                    }
                }
            }
        }

        
        // Update the UI with the given parameters
        function updateUIWithParameters(value) {

            const ajustParameter = [
                value.PFC_High,
                value.PFC_Low,
                value.Active_HighOffset,
                value.Active_LowOffset
            ];

            document.querySelector('.modal-Graph').style.display = 'block';
            document.querySelector('.SetUp').style.display = 'block';

            document.getElementById('HighThreshold_Modal').value = ajustParameter[0];
            document.getElementById('LowThreshold_Modal').value = ajustParameter[1];
            document.getElementById('HighOffset_Modal').value = parseFloat(ajustParameter[2]) + parseFloat(ajustParameter[0]);
            document.getElementById('LowOffset_Modal').value = parseFloat(-ajustParameter[3]) + parseFloat(ajustParameter[1]);
            document.getElementById('<%= StoredID_Database.ClientID %>').value = value.Key;

            resetChart();
            sessionStorage.setItem('_SelectLastValue', 240); // Set default 4h
            updateActiveButtonScalePopUp('Scale4h');
            LoadData_Setup(value.Key, value.TagDesc);
           
        }

        // Update parameter levels by making an AJAX call
        function updateParameterLevel(ID_Selected, _SearchByID_Number) {
            return new Promise((resolve, reject) => {

                const _Factory = sessionStorage.getItem('_FactoryResponsibility');
                const _Location = sessionStorage.getItem('_LocationResponsibility');
                const _Line = sessionStorage.getItem('_LineResponsibility');

                $.ajax({
                    type: "POST",
                    url: "Alarm.aspx/LoadDataPara",
                    data: JSON.stringify({ ID: ID_Selected, SearchByID: _SearchByID_Number, FactoryArea: _Factory, Location: _Location, Line: _Line }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_Receive) {
                        Package_DataPara = JSON.parse(Data_Receive.d);
                        resolve();
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(error);
                    }
                });
            });
        }

        // Update the timestamp in Chart PopUp
        function updateTimestamp(minusminute, target, GetTimeNow) {
            var currentDate = new Date();
            if (GetTimeNow == true) {
                
                currentDate.setMinutes(currentDate.getMinutes() - minusminute);
                target.value = toLocalISOString(currentDate);
            } else {
                console.log(target.value);
                currentDate = new Date(target.value);
                currentDate.setMinutes(currentDate.getMinutes() - minusminute);
                target.value = toLocalISOString(currentDate);
            }
               
        }

        // Function PopUp chart 

        function UpdateChart(KeyLine, color, shape) {
            // Get the new y-value as a number
            var newYValue = parseFloat(document.getElementById(KeyLine).value);
            var language = document.getElementById('<%= languageField.ClientID %>').value;
            
            var labelForLevel = JSON.parse(language);

            if (KeyLine == 'HighOffset_Modal')
                KeyLine = labelForLevel.Active_HighOffset;
            else if (KeyLine == 'LowOffset_Modal')
                KeyLine = labelForLevel.Active_LowOffset;
            else if (KeyLine == 'HighThreshold_Modal')
                KeyLine = labelForLevel.PFC_High;
            else if (KeyLine == 'LowThreshold_Modal')
                KeyLine = labelForLevel.PFC_Low;




            UpdateConstantLine(newYValue, KeyLine, color, shape); // draw line level in chart 




            if (KeyLine == 'HighThreshold_Modal')
                document.getElementById('HighOffset_Modal').onchange();
            if (KeyLine == 'LowThreshold_Modal')
                document.getElementById('LowOffset_Modal').onchange();
        }

        function UpdateConstantLine(newYValue, lineName, color, shape) {
            // Find the series representing the constant line by name
            var constantLineSeries = chart.series.find(series => series.name === lineName);
            
            if (constantLineSeries) {
                // Update the data point of the constant line with the new y-value
                constantLineSeries.setData([[constantLineSeries.data[0].x, newYValue], [constantLineSeries.data[1].x, newYValue]]);
                constantLineSeries.update({ name: lineName }); // Update the name of the constant line
            } else {
                // Series not found, add a new constant line
                var xAxis = chart.xAxis[0];
                var minX = xAxis.dataMin;
                var maxX = xAxis.dataMax;

                // Add a new series with a horizontal line at the new y-value spanning the x-axis range
                var constantSeriesOptions = {
                    name: lineName,
                    type: 'line',
                    data: [[minX, newYValue], [maxX, newYValue]],
                    lineWidth: 1,
                    color: color,
                    marker: {
                        symbol: shape,
                        
                        lineWidth: 2
                    }
                };

                chart.addSeries(constantSeriesOptions);
                chart.update(Update_Chart_Option);
               
                
            }

            chart.redraw();
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
                chart.zoomOut();
                // Redraw the chart
                chart.redraw();
            } 
                        
        }

        // Load data for chart PopUp 

        function LoadData_Setup(TagDesc , NameChart) {
            const colors = Highcharts.getOptions().colors;

            var TimeSelected = document.getElementById('SelectedTimePopUp').value
            var Package_Send = TagDesc + ',' + TimeSelected + ',' + sessionStorage.getItem('_SelectLastValue'); 
            
            $.ajax({
                type: "POST",
                url: "Alarm.aspx/LoadDataPopUp",
                data: JSON.stringify({ Package: Package_Send }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_Receive) {
                    Data_Receive = JSON.parse(Data_Receive.d);
                    var seriesOptions = {
                        name: NameChart,
                        type: 'line',
                        data: Data_Receive.map(function (item) {
                           // console.log((new Date(item[0])).getTime());
                            return [(new Date(item[0])).getTime(), parseFloat(item[1])];
                        }),
                        color: colors[4],
                        lineWidth: 1,
                        connectNulls: false,
                        rangeSelector: {
                            enabled:false,
                        }
                        
                    };
                  
                    // Draw the chart line Signal 

                    chart.addSeries(seriesOptions);
                    chart.update(Update_Chart_Option);
                    chart.redraw();

                    // Draw out the Line Threshold

                    document.getElementById('HighThreshold_Modal').onchange();
                    document.getElementById('LowThreshold_Modal').onchange();
                    document.getElementById('HighOffset_Modal').onchange();
                    document.getElementById('LowOffset_Modal').onchange();

                    document.getElementById('calendar').style.display = 'flex';
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    
                }



            }); 

            


        }

        // Function PFC Parameter

        function UpdateParameterlevel(ID_Selected, _SearchByID_Number) {
            return new Promise(function (resolve, reject) {

                const _Factory = sessionStorage.getItem('_FactoryResponsibility');
                const _Location = sessionStorage.getItem('_LocationResponsibility');
                const _Line = sessionStorage.getItem('_LineResponsibility');

                $.ajax({
                    type: "POST",
                    url: "Alarm.aspx/LoadDataPara",
                    data: JSON.stringify({ ID: ID_Selected, SearchByID: _SearchByID_Number, FactoryArea: _Factory, Location: _Location, Line: _Line }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_TagDesc_Receive) {
                        Package_DataPara = JSON.parse(Data_TagDesc_Receive.d);
                        
                        resolve(); // Resolve the promise when the AJAX request is successful
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(error); // Reject the promise if there's an error
                    }
                });
            });
        }

        // Create Tag Page for PFC (Based on the dynamic data)

        function CreatetagPFC() {

            const _Factory = sessionStorage.getItem('_FactoryResponsibility');
            const _Location = sessionStorage.getItem('_LocationResponsibility');
            const _Line = sessionStorage.getItem('_LineResponsibility');
            // Create Tag PFC//
            $.ajax({
                type: "POST",
                url: "Alarm.aspx/LoadDataPara",       
                data: JSON.stringify({ ID: "All", SearchByID: false, FactoryArea: _Factory, Location: _Location, Line:_Line  }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_TagDesc_Receive) {
                    Package_DataPara = JSON.parse(Data_TagDesc_Receive.d);

                    for (var key in Package_DataPara) {
                        if (Package_DataPara.hasOwnProperty(key)) {
                            createNavItem(key, Package_DataPara[key]);
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    reject(error); // Reject the promise if there's an error
                }
            });

            const Factory = sessionStorage.getItem('_FactoryResponsibility');  
            const Location = sessionStorage.getItem('_LocationResponsibility');  
            const Line = sessionStorage.getItem('_LineResponsibility');  

            LoadDisableAlarm(null, Factory, Location, Line);


        }

        // Create static Page for stored the data PFC

        //function createNavItem(key, values) {
        //    // Create nav item div
        //    var itemDiv = document.createElement('div');
        //    itemDiv.classList.add('nav-item');


        //    // Create div contains the contains a machine
        //    var itemContent = document.createElement('div');
        //    itemContent.classList.add('nav-item-content');

        //    // Create div nav link
        //    var element = document.createElement('div');
        //    element.classList.add('nav-link');
        //    element.setAttribute('data-bs-toggle', 'collapse');
        //    element.textContent = key;
        //    element.addEventListener('click', function () {

                 

        //        var options = this.parentElement.nextElementSibling;

        //        options.classList.toggle('show');
                
        //        options.querySelectorAll(".detail").forEach(function (Option) {
        //            updateMachineName(Option.id); 
        //        });

        //        var contentParent = this.parentElement;
        //        if (contentParent.classList.contains("active")) {
        //            contentParent.classList.remove("active");
        //        } else {
        //            contentParent.classList.add("active");
        //        }


        //    });
           
                
        //    // Create button enable/disable
        //    var ButtonEnable = document.createElement('button');

        //    ButtonEnable.classList.add('btn','btn-lg', 'btn-toggle');
        //    ButtonEnable.setAttribute('type', 'button');
        //    ButtonEnable.setAttribute('data-toggle', 'button');
        //    ButtonEnable.setAttribute('aria-pressed', 'false');
        //    ButtonEnable.setAttribute('autocomplete', 'off');
           

        //    // Create handle div inside the button
        //    var handleDiv = document.createElement('div');
        //    handleDiv.classList.add('handle');
        //    ButtonEnable.appendChild(handleDiv);

        //    ButtonEnable.addEventListener('click', function (event) {
        //        event.stopPropagation();
        //        var confirmChange = window.confirm('Are you sure you want to disable the machine alarm ?');

        //        if (confirmChange) {
  
        //            // Get the value of the button's state
        //            var isOn = this.classList.contains('active');
        //            var value = isOn ? '0' : '1';
        //            var IDEnable = this.previousElementSibling;

        //            DisableAlarm(IDEnable.id, value, null, function (isSuccess) {
                       
        //                if (isSuccess) {
        //                    Parameters = key.split('-'); 

        //                    LoadDisableAlarm(Parameters[0], Parameters[1], Parameters[2], Parameters[3]); 
        //                } else {
        //                    alert('Failed to update alarm status.');
        //                }
        //            });

                    
        //        } else {
        //            // Do nothing or handle the cancellation
        //        }
                

        //    });

        //    // Create options list
        //    var optionsList = document.createElement('div');
        //    optionsList.classList.add('options', 'collapse');
            
        //    var machineContainers = {};
        //    values.forEach(function (value) {
                
        //        var listItem = document.createElement('div');
        //        listItem.classList.add('detail');

        //        // Create icon
        //        var icon = document.createElement('i');
        //        icon.classList.add('fas', 'fa-icon'); // Assuming you're using Font Awesome
        //        listItem.appendChild(icon);

        //        var textSpan = document.createElement('span');
        //        textSpan.textContent = value.TagDesc; // Set the text content of the span
        //       /* textSpan.style.display = 'none'; // Hide the span*/
        //        listItem.appendChild(textSpan);



        //        var SumpfcContainer = document.createElement('div');
        //        SumpfcContainer.classList.add('PFCGroup')
        //        // Create PFC container for each set of PFC icon and text
        //        for (var i = 1; i <= 4; i++) {
        //            var pfcContainer = document.createElement('div');

        //            // Create PFC icon dynamically based on index
        //            var pfcIcon = document.createElement('i');
        //            pfcIcon.classList.add(getPfcIconClassHeader(i), getPfcIconClass(i), getPfcIconClassPro(i));
        //            pfcIcon.style.color = getPfcclolor(i);
        //            pfcContainer.appendChild(pfcIcon);

        //            // Add PFC text
        //            var pfcText = document.createTextNode(getPfcText(value, i)); // Get PFC text dynamically based on index
        //            pfcContainer.appendChild(pfcText);

        //            // Append PFC container to list item
        //            SumpfcContainer.appendChild(pfcContainer);
        //        }
        //        listItem.appendChild(SumpfcContainer);
        //        // Set ID for list item
        //        listItem.setAttribute('id', value.Key);

        //        // Add click event listener
        //        listItem.onclick = function (event) {
        //            openPopUpSession();
        //            var textContent = this.querySelector('span').textContent;
        //            var text_Location = value.FactoryArea + "-" + value.Location + "-" + value.Line;  
        //            ModifyLevel(this.id, textContent, text_Location );
        //        };

        //        // Create or get MachineID container
        //        var machineID = value.MachineID;
        //        if (!machineContainers[machineID]) {
                    
        //            var MachineIDHeader = document.createElement('div'); 
        //            MachineIDHeader.classList.add('MachineHeader'); 
        //            // add text 
        //            var textSpan = document.createElement('span');
        //            textSpan.textContent = value.Machinelabel + " - " + value.MachineID; 
        //            //Set Id for Options and  Hedear 
        //            element.id = value.MachineType + "-" + value.FactoryArea + "-" + value.Location + "-" + value.Line; 
        //            optionsList.setAttribute('id', value.MachineType + "-" + value.FactoryArea + "-" + value.Location+ "-" + value.Line);
        //            ButtonEnable.id = value.MachineType + "-" + value.FactoryArea + "-" + value.Location + "-" + value.Line +"_Button";
        //            MachineIDHeader.appendChild(textSpan);

        //            MachineIDHeader.addEventListener('click', function () {
        //                var contentParent = this;
        //                if (contentParent.classList.contains("active")) {
        //                    contentParent.classList.remove("active");
        //                } else {
        //                    contentParent.classList.add("active");
        //                }
        //                var Detail = this.nextElementSibling;
        //                Detail.style.display = Detail.style.display === 'block' ? 'none' : 'block';  
        //            });  
        //            MachineIDHeader.setAttribute('id', value.MachineID);
        //            // Create button enable/disable
        //            var ButtonEnableMachineId = document.createElement('button');

        //            ButtonEnableMachineId.classList.add('btn', 'btn-lg', 'btn-toggle');
        //            ButtonEnableMachineId.setAttribute('type', 'button');
        //            ButtonEnableMachineId.setAttribute('data-toggle', 'button');
        //            ButtonEnableMachineId.setAttribute('aria-pressed', 'false');
        //            ButtonEnableMachineId.setAttribute('autocomplete', 'off');
        //            ButtonEnableMachineId.setAttribute('id', value.MachineID +'_Button' );
        //            // Create handle div inside the button
        //            var handleDiv = document.createElement('div');
        //            handleDiv.classList.add('handle');
        //            ButtonEnableMachineId.appendChild(handleDiv);

        //            //Create disable button for MachineID
        //            ButtonEnableMachineId.addEventListener('click', function (event) {
        //                event.stopPropagation();
        //                var confirmChange = window.confirm('Are you sure you want to disable the machine alarm ?');

        //                if (confirmChange) {

        //                    // Get the value of the button's state
        //                    var isOn = this.classList.contains('active');
        //                    var FlagValue = isOn ? '0' : '1';
        //                    var MachineID = this.parentElement;
                            

        //                    DisableAlarm(optionsList.id, FlagValue, MachineID.id, function (isSuccess) {

        //                        if (isSuccess) {
        //                            LoadDisableAlarm(value.MachineType, value.FactoryArea, value.Location, value.Line); 
                                   
        //                        } else {
        //                            alert('Failed to update alarm status.');
        //                        }
        //                    });


        //                } else {
        //                    // Do nothing or handle the cancellation
        //                }


        //            });


        //            MachineIDHeader.appendChild(ButtonEnableMachineId);  

        //            optionsList.appendChild(MachineIDHeader);

        //            var MachineIDContainer = document.createElement('div');
        //            MachineIDContainer.classList.add('machine-container');
        //            MachineIDContainer.style.display = 'none'; 
        //            machineContainers[machineID] = MachineIDContainer;



        //            optionsList.appendChild(MachineIDContainer); // Append MachineID container to optionsList

        //        }

        //        // Append listItem to MachineID container
        //        machineContainers[machineID].appendChild(listItem);
               
        //    });

        //    itemContent.appendChild(element);
        //    itemContent.appendChild(ButtonEnable);


        //    itemDiv.appendChild(itemContent);
        //    itemDiv.appendChild(optionsList);

        //    // Append to document
        //    document.getElementById('MachineName').appendChild(itemDiv);
        //}

        // Update static page PFC //

        function updateMachineName(elementId) {
            // Clear the content inside based on the elementId
            UpdateParameterlevel(elementId, false)
                .then(function () {
                    var element = document.getElementById(elementId);
                    if (element) {
                        // Loop through each element with class name PFCGroup inside the element
                        var pfcGroupElements = element.querySelectorAll('.PFCGroup');
                        pfcGroupElements.forEach(function (pfcGroupElement) {
                            // Clear the content of each PFCGroup element
                            pfcGroupElement.innerHTML = '';

                            // Loop through the data and create PFC containers
                            for (var key in Package_DataPara) {
                                if (Package_DataPara.hasOwnProperty(key)) {
                                    // Create PFC container for each set of PFC icon and text
                                    for (var index = 1; index <= 4; index++) {
                                        var pfcContainer = document.createElement('div');

                                        // Create PFC icon dynamically based on index
                                        var pfcIcon = document.createElement('i');
                                        pfcIcon.classList.add(getPfcIconClassHeader(index), getPfcIconClass(index), getPfcIconClassPro(index));
                                        pfcIcon.style.color = getPfcclolor(index);
                                        pfcContainer.appendChild(pfcIcon);

                                        // Add PFC text
                                        Package_DataPara[key].forEach(function (value) {
                                            var textNode = document.createTextNode(getPfcText(value, index)); // Call getPfcText for each value in the array
                                            pfcContainer.appendChild(textNode); // Append each text node to pfcText
                                        });

                                        // Append PFC container to PFCGroup element
                                        pfcGroupElement.appendChild(pfcContainer);
                                    }
                                }
                            }
                        });
                    }
                })
                .catch(function (error) {
                    console.error(error);
                });
        }

        // Window Load 

        window.onload = function () {
            //startFetchingID();
            const TagActive = sessionStorage.getItem('_TagCurrentAlarm');

            closePopUpSession();
            if (TagActive=='null')
                handleClick('AlarmRecord_Tag');
            else 
                handleClick(TagActive);
        };

        $(window).add(document).scroll(function () {
           
            if ($(window).scrollTop() + $(window).height() >= $(document).height() - 100) {
                const TagActive = sessionStorage.getItem('_TagCurrentAlarm');
                if (TagActive == 'AlarmRecord_Tag') {
                    LoadDataAlarm(false, 'AlarmRecord');
                }
            }
        });

        function LoadDisableAlarm(Machine, FactoryArea, Location,  Line ){

            var PackageSend = {
                Machine: Machine,
                FactoryArea: FactoryArea,
                Location: Location, 
                Line : Line
            };

            $.ajax({
                type: "POST",
                url: "Alarm.aspx/LoadstatusDisableAlarm",
                data: JSON.stringify({ Package: PackageSend }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_Receive) {
                    
                    Data_Receive = JSON.parse(Data_Receive.d);
                    var StatusallMachineType = {};
                    console.log(Data_Receive);
                    Data_Receive.forEach(function (value) {

                        var MachineIdButton = document.getElementById(value[0] + "_Button");
                        var parentOptions = MachineIdButton.closest('.options');
                        var parentOptionsID = parentOptions.id.split('_');
                       
                        var MachineTypeButton = document.getElementById(parentOptionsID[0] + "_Button");

                        if (!MachineTypeButton) return; // Check if MachineTypeButton exists

                        if (StatusallMachineType[MachineTypeButton.id] === undefined) {
                            StatusallMachineType[MachineTypeButton.id] = false;
                        }

                        if (value[1] === "True") {
                            
                            MachineIdButton.classList.add('active');
                            StatusallMachineType[MachineTypeButton.id] = true;
                        } else {
                            MachineIdButton.classList.remove('active');
                        }
                    });

                    Object.entries(StatusallMachineType).forEach(function ([machine, status]) {
                        var machineButton = document.getElementById(machine);
                        if (machineButton) {
                            
                            if (status) {          
                                machineButton.classList.add('active');
                            } else {
                                
                                machineButton.classList.remove('active');
                            }
                        }
                    
                    });
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    reject(error); // Reject the promise if there's an error
                }
            });
        }

        function LoadDataByID(ID) {

            $.ajax({
                type: "POST",
                url: "Alarm.aspx/LoadstatusDisableAlarm",
                data: JSON.stringify({ Package: PackageSend }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_Receive) {

                },
                error: function (xhr, status, error) {
                    console.error(error);
                    reject(error); // Reject the promise if there's an error
                }
            });
        }

    </script>

    <!-- Multiple DropDown List Process -->

    <script>
        $(document).ready(function () {
            // Define variables
            var placeholderMachine = document.getElementById('<%= PlaceHolderMultiple1.ClientID %>').value;
            var placeholderData = document.getElementById('<%= PlaceHolderMultiple2.ClientID %>').value;

            // Function to initialize VirtualSelect
            function initializeVirtualSelect(elementId, placeholder) {
                VirtualSelect.init({
                    ele: "#" + elementId,
                    multiple: true,
                    placeholder: placeholder
                });
            }

            // Function to destroy and reinitialize VirtualSelect for Multiple2
            function resetVirtualSelect2() {
                var multiple2Element = document.querySelector('#Multiple2');
                if (multiple2Element) {
                    multiple2Element.destroy();
                }
                initializeVirtualSelect('Multiple2', placeholderData);
            }

            // Initialize VirtualSelect for Multiple1 and Multiple2
            initializeVirtualSelect('Multiple1', placeholderMachine);
            initializeVirtualSelect('Multiple2', placeholderData);

            // Retrieve and parse data from the server
            var dataTagNameReceive = document.getElementById('<%= StoredAddress.ClientID %>').value;
            var dataTagNamePopulate = JSON.parse(dataTagNameReceive).map(item => ({ label: item.Label, value: item.Value }));

            // Set options for Multiple1
            var multiple1Element = document.querySelector('#Multiple1');
            multiple1Element.reset();
            multiple1Element.setOptions(dataTagNamePopulate);

            // Event handler for change event on Multiple1
            $('#Multiple1').on('change', function () {
                var selectedValues = $(this).val();
                var dataTagName = selectedValues.join(",");
                var dataFactory = document.getElementById('<%= DropDownList1.ClientID %>').value;
                var dataLine = document.getElementById('<%= DropDownList2.ClientID %>').value;

                // AJAX request to get data for Multiple2
                $.ajax({
                    type: "POST",
                    url: "Alarm.aspx/LoadDataTagDesc",
                    data: JSON.stringify({ Machine_Value: dataTagName, Location_Value: dataFactory, Line_Value: dataLine }),
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (response) {
                        var dataTagDescReceive = JSON.parse(response.d);
                        if (dataTagDescReceive.length !== 0) {
                            resetVirtualSelect2();
                            dataTagDescReceive = dataTagDescReceive.map(item => ({ label: item.Label, value: item.Value }));
                            var multiple2Element = document.querySelector('#Multiple2');
                            multiple2Element.reset();
                            multiple2Element.setOptions(dataTagDescReceive);
                        } else {
                            resetVirtualSelect2();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                });
            });
        });
    </script>

    <!-- Process Element or component by Adding EventListener -->

    <script>

        function SwitchtodayNow( event) {
            event.preventDefault();

            sessionStorage.setItem('_LoadCurrentTime', true); 
            const calendar = document.getElementById("SelectedTimePopUp");
            updateTimestamp(240, calendar , true);
            toggleFunction('Scale4h', event);
            const ButtonNow = document.getElementById("GetNow");
            ButtonNow.classList.add('active'); 
        }

        function toggleFunction(buttonId, event) {
            event.preventDefault();
            
            updateActiveButtonScalePopUp(buttonId);

            // prepare data for chart 
            const calendarInput = document.getElementById("SelectedTimePopUp");
           
            sessionStorage.setItem('_SelectLastScalePopUp', buttonId);

            var KeySearch = document.getElementById('<%= StoredID_Database.ClientID %>').value
            var NameSignal = document.getElementById('Description_Modal').textContent;

            // Draw and Load out data
            resetChart();
            adjustDate(calendarInput, null, false);
            chart.redraw();

        }

        function updateActiveButtonScalePopUp(buttonId) {
            // Remove 'active' class from all buttons within '.ButtonScale'
            document.querySelectorAll('.ButtonScale .button').forEach(button => {
                button.classList.remove('active');
            });

            // Get the button element by its ID
            const buttonScaleID = document.getElementById(buttonId);

            // Ensure the button exists before adding the 'active' class
            if (buttonScaleID) {
                buttonScaleID.classList.add('active');
            }
            sessionStorage.setItem('_SelectLastScalePopUp', buttonId);

        }

        function toggleOptions(optionId) {

            // Ajust the styles of Tilte Setup Parameter // 

            var options = document.getElementById(optionId);
            if (options.classList.contains('show')) {
                options.classList.remove('show');
            } else {
                options.classList.add('show');
            }

            // Loading Data //
            if (options.classList.contains('show')) {   
                $.ajax({
                    type: "POST",
                    url: "Alarm.aspx/LoadDataWorkTime",
                    contentType: "application/json; charset=UTF-8",
                    dataType: "json",
                    success: function (Data_Receive) {
                        var workTime = JSON.parse(Data_Receive.d);
                        document.getElementById("Start_TimeStampSetUp").value = workTime[0].StartWorkTime;
                        document.getElementById("StartBreak_TimeStampSetUp").value = workTime[0].StartBreakTime;
                        document.getElementById("EndBreak_TimeStampSetUp").value = workTime[0].EndBreakTime;
                        document.getElementById("End_TimeStampSetUp").value = workTime[0].EndWorkTime;
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                        reject(error); // Reject the promise if there's an error
                    }
                });
            }


        }

        function handleIconClickAlarm(iconId) {

            var cells = $('#' + iconId).closest('tr').find('td');
            document.querySelector('.SetUp').style.display = 'none';
            document.querySelector('.modal-Graph').style.display = 'none';
            document.querySelector('.Infor-Sub').style.display = 'none';
            // Get the ID from the first cell
            var id = $(cells[0]).text();

            document.getElementById('<%= StoredID_Database.ClientID %>').value = iconId.split("_").slice(2).join(" ");

            document.getElementById('Description_Modal').textContent = id;
            $('.close').on('click', function () {
                $('#myModal').css('display', 'none');
            });
            // Show the modal
            $('#myModal').css('display', 'block');

            sessionStorage.setItem('_ExtendFlag', JSON.stringify(true));


        }

        // Update Data in PopUp in SetUpPFC Tag  
        function ModifyLevel(iconId, TextContext , Text_Location ) {


            document.querySelector('.SetUp').style.display = 'none';
            document.querySelector('.modal-Graph').style.display = 'none';
            document.querySelector('.Infor-Sub').style.display = 'none';
            document.getElementById('Description_Modal').textContent = TextContext;
            document.getElementById('Line_Modal').textContent = Text_Location;


            $('.close').on('click', function () {
                $('#myModal').css('display', 'none');
            });
            // Show the modal
            $('#myModal').css('display', 'block');

            document.getElementById('<%= StoredID_Database.ClientID %>').value = iconId;
            
            sessionStorage.setItem('_ExtendFlag', JSON.stringify(true));
            Extend_SetStandard();


        }

        var modalContent = document.querySelector('.modal-content');
        var modalGraph = document.querySelector('.modal-Graph');

        // JavaScript
        document.addEventListener("DOMContentLoaded", function () {
            const calendarIcon = document.getElementById("calendarIcon");
            const calendarInput = document.getElementById("SelectedTimePopUp");
            const decreaseIcon = document.getElementById("decreaseDate");
            const increaseIcon = document.getElementById("increaseDate");



            decreaseIcon.addEventListener("click", function () {

                sessionStorage.setItem('_LoadCurrentTime', false); 
                const ButtonNow = document.getElementById("GetNow");
                ButtonNow.classList.remove('active'); 


                adjustDate(calendarInput, -1, true);

            });

            increaseIcon.addEventListener("click", function () {

                sessionStorage.setItem('_LoadCurrentTime', false); 
                const ButtonNow = document.getElementById("GetNow");
                ButtonNow.classList.remove('active');
                adjustDate(calendarInput, 1, true);


            });

            // Event listener to detect changes in the datetime-local input field
            calendarInput.addEventListener('change', function (event) {
                sessionStorage.setItem('_LoadCurrentTime', false); 
                const ButtonNow = document.getElementById("GetNow");
                ButtonNow.classList.remove('active');
                const currentDate = new Date(calendarInput.value);
                updateDateInput(calendarInput, currentDate);

            });

        });

        function adjustDate(calendarInput, adjustment, EnableAjustDay) {
            const currentDate = new Date(calendarInput.value);
            let scaleMultiplier = 1;
           
            switch (sessionStorage.getItem('_SelectLastScalePopUp')) {
                case "Scale15p":
                    scaleMultiplier = 15;
                    break;
                case "Scale30p":
                    scaleMultiplier = 30;
                    break;
                case "Scale1h":
                    scaleMultiplier = 60;
                    break;
                case "Scale4h":
                    scaleMultiplier = 240;
                    break;
                case "Scale1d":
                    scaleMultiplier = 1440;
                    break;
               
            }

            if (EnableAjustDay) {
                if (scaleMultiplier !== 1) {
                    currentDate.setMinutes(currentDate.getMinutes() + adjustment * scaleMultiplier);
                } else {
                    currentDate.setDate(currentDate.getDate() + adjustment);
                }
            }

            if (sessionStorage.getItem('_LoadCurrentTime') === "true") {
               
                updateTimestamp(scaleMultiplier, calendarInput, true);
                
            }


            sessionStorage.setItem('_SelectLastValue', scaleMultiplier);
            updateDateInput(calendarInput, currentDate);
        }

        function updateDateInput(inputElement, date) {
            if (!(sessionStorage.getItem('_LoadCurrentTime') === "true") ){
                // Format the date in YYYY-MM-DDTHH:MM format
                const formattedDate = toLocalISOString(date);
                inputElement.value = formattedDate;


            }

            //Update chart Data
            var KeySearch = document.getElementById('<%= StoredID_Database.ClientID %>').value
            var NameSignal = document.getElementById('Description_Modal').textContent;

            resetChart();
            LoadData_Setup(KeySearch, NameSignal);

        }

        // Add click event listener to the zoom icon
        zoomIcon.addEventListener('click', function () {

            var isFullWidth = modalContent.classList.contains('full-width');
            // Toggle class to resize modal width
            modalContent.classList.toggle('full-width', !isFullWidth);


            modalGraph.classList.toggle('full-width', !modalGraph.classList.contains('full-width'))


            if (modalGraph.classList.contains('full-width')) {
                modalGraph.style.display = 'none';
                modalGraph.style.display = 'block';
            }

        });

        // Add click event listener to the close icon
        CloseIcon.addEventListener('click', function () {

            closePopUpSession();
            // Hide the Modal 
            $('#myModal').css('display', 'none');

        });


        // the input in color bar is Active? 

        var valueInputsContainer = document.querySelector('.value-inputs');
        
        // Add event listener for clicks on the container
        valueInputsContainer.addEventListener('click', function (event) {
            // Check if the clicked element is an input field

            if ((event.target.tagName === 'INPUT') && (document.getElementById('ChangeID').style.display == 'none')) {
                document.getElementById('ChangeID').style.display = 'flex';
                document.getElementById('ValueThreshold').value = document.getElementById(event.target.id).value;
                sessionStorage.setItem('_ValueLastInputColorbar', document.getElementById(event.target.id).value );
                // Call a function to handle the click
                
                sessionStorage.setItem('_AjustThreshold_ID', event.target.id);
                sessionStorage.setItem('_FormatNumber', true);
                event.target.classList.add('active');

                // handleInputClick(event.target.id);
            }
            else if (sessionStorage.getItem('_AjustThreshold_ID') == event.target.id) {
                document.getElementById('ChangeID').style.display = 'none';
                sessionStorage.setItem('_ValueLastInputColorbar', null);
                sessionStorage.setItem('_FormatNumber', true);
                event.target.classList.remove('active');
            }
            else {

                document.getElementById('ChangeID').style.display = 'flex';
                document.getElementById('ValueThreshold').value = document.getElementById(event.target.id).value;
                sessionStorage.setItem('_ValueLastInputColorbar', document.getElementById(event.target.id).value);
                document.getElementById(sessionStorage.getItem('_AjustThreshold_ID')).classList.remove('active');
                event.target.classList.add('active');     
                sessionStorage.setItem('_AjustThreshold_ID', event.target.id);
                sessionStorage.setItem('_FormatNumber', true);
            }
        });

        function RemoveSelectedInColorBar() {
            
           
            if (sessionStorage.getItem('_AjustThreshold_ID')) {
                var activeElement = document.getElementById(sessionStorage.getItem('_AjustThreshold_ID'));
                if (activeElement) {
                    activeElement.classList.remove('active');
                }
                document.getElementById('ChangeID').style.display = 'none';
                
            }
        }

        // Update value Set up in color bar

        function UpdateThreshold(step) {
            const ActiveId = sessionStorage.getItem('_AjustThreshold_ID');
            var valueInput = document.getElementById('ValueThreshold');
            var ValueUpdate = document.getElementById(ActiveId);
            var currentValue = parseFloat(valueInput.value); // Parse the current value, default to 0 if empty or not a number

            if (isNaN(currentValue)) {
                // If the input is not a number, show an alert
                alert(document.getElementById('<%= Error.ClientID %>').value);
                document.getElementById('ValueThreshold').value = sessionStorage.getItem('_ValueLastInputColorbar'); 
                sessionStorage.setItem('_FormatNumber', true);
                return; // Exit the function if input is not a number
            }


            var newValue = currentValue + parseFloat(step); // Calculate the new value
            valueInput.value = newValue;
            ValueUpdate.value = newValue;
            document.getElementById(ActiveId).onchange();


        }


        // Add event listener for clicks on the container
        function ChangeByInputLevel() {
            const ActiveId = sessionStorage.getItem('_AjustThreshold_ID');
            var valueThresholdInput = document.getElementById('ValueThreshold');
            var ValueUpdate = document.getElementById(ActiveId);
            var currentValue = parseFloat(valueThresholdInput.value); // Parse the current value, default to 0 if empty or not a number
            if (isNaN(currentValue)) {
                // If the input is not a number, show an alert
                alert(document.getElementById('<%= Error.ClientID %>').value);
                sessionStorage.setItem('_FormatNumber', false);
                return; // Exit the function if input is not a number
            } else {
                valueThresholdInput.value = currentValue;
                ValueUpdate.value = currentValue;
                sessionStorage.setItem('_FormatNumber', true);
            }

            
            document.getElementById(ActiveId).onchange();

        };


        function toLocalISOString(date) {
            const localDate = new Date(date - date.getTimezoneOffset() * 60000); //offset in milliseconds. Credit https://stackoverflow.com/questions/10830357/javascript-toisostring-ignores-timezone-offset

            // Optionally remove second/millisecond if needed
            localDate.setSeconds(null);
            localDate.setMilliseconds(null);
            return localDate.toISOString().slice(0, -1);
        }

        // Disable Alarm Machine

        function DisableAlarm(NameMachines, value, MachineID, callback) {
            var NameMachine = NameMachines.split("-");

            var Package_DisableAlarm = {
                Machine: NameMachine[0],
                FactoryArea: NameMachine[1],
                Location: NameMachine[2],
                Line : NameMachine[3],
                MachineID: MachineID,
                value: value
            };

            $.ajax({
                type: "POST",
                url: "Alarm.aspx/DisableAlarm",
                data: JSON.stringify({ Package: Package_DisableAlarm }),
                contentType: "application/json; charset=UTF-8",
                dataType: "json",
                success: function (Data_Receive) {
                    callback(Data_Receive.d); // Pass the result to the callback function
                },
                error: function (xhr, status, error) {
                    alert(error);
                    callback(false); // Pass false to the callback function on error
                }
            });
        }


    </script>

    <!-- Manage Session Storage -->

    <script>    


        $(document).ready(function () {

            SessionForAlarmPage();
            CreatetagPFC();

        });


        // function to set session storage item if not already set
        function setSessionStorageItem(key, defaultValue) {
            let value = sessionStorage.getItem(key);
            if (!value) {
                sessionStorage.setItem(key, defaultValue);
                value = defaultValue;
            }
            return value;
        }

        // Function to set new session storage items for the popup

        function openPopUpSession() {
            setSessionStorageItem('_SelectLastScalePopUp', '4h');
            setSessionStorageItem('_SelectLastValue', 240);
            setSessionStorageItem('_ExtendFlag', JSON.stringify(true));
            setSessionStorageItem('_AjustThreshold_ID', null);
            setSessionStorageItem('_ValueLastInputColorbar', null);
            setSessionStorageItem('_FormatNumber', true);
            setSessionStorageItem('_LoadCurrentTime', true);

            //if (sessionStorage.getItem('_TagCurrentAlarm') != 'SetPFC_Tag') {

            //    setSessionStorageItem('_Description_ID ', null);
            //    setSessionStorageItem('_Reason_ID', null);
            //    setSessionStorageItem('_Comment_ID', null);
            //    setSessionStorageItem('_Comment_ID', null);


            //}


        }

        // Function to clear session storage items for the popup

        function closePopUpSession() {

            RemoveSelectedInColorBar();  // remove the selected cell

            sessionStorage.removeItem('_SelectLastScalePopUp');
            sessionStorage.removeItem('_SelectLastValue');
            sessionStorage.removeItem('_ExtendFlag');
            sessionStorage.removeItem('_AjustThreshold_ID');
            sessionStorage.removeItem('_ValueLastInputColorbar');
            sessionStorage.removeItem('_FormatNumber');
            sessionStorage.removeItem('_LoadCurrentTime');


        }

        // Function to set new session storage items for the First load

        function SessionForAlarmPage() {


            setSessionStorageItem('_LocationResponsibility', 'S2');
            setSessionStorageItem('_LineResponsibility', '1');
            setSessionStorageItem('_FactoryResponsibility', 'VH');
            setSessionStorageItem('_TagCurrentAlarm', null);
            setSessionStorageItem('_EnableSound', false);

        }

       

    </script>


    <!-- Fucntion Create Tag PFC and Process and Update threshold -->

    <script>

        // Function Create 1 tag //
        function createNavItem(key, values) {
            var itemDiv = createElement('div', ['nav-item']);
            var itemContent = createElement('div', ['nav-item-content']);
            var element = createNavLink(key);
            var ButtonEnable = createButtonEnable(key);

            element.addEventListener('click', function () {
                toggleOptionsMachine(this, key);
            });

            var optionsList = createOptionsList(values, key, element, ButtonEnable );


            itemContent.appendChild(element);
            itemContent.appendChild(ButtonEnable);

            itemDiv.appendChild(itemContent);
            itemDiv.appendChild(optionsList);

            document.getElementById('MachineName').appendChild(itemDiv);
        }


        function createElement(tag, classes) {
            var element = document.createElement(tag);
            if (classes) {
                element.classList.add(...classes);
            }
            return element;
        }

        // Create Header for Machine Type 

        function createNavLink(key) {
            var navLink = createElement('div', ['nav-link']);
            navLink.setAttribute('data-bs-toggle', 'collapse');
            navLink.textContent = key;
            return navLink;
        }

        // Create Button for Clicking Enable/Disable Machine Type

        function createButtonEnable(key) {
            var button = createElement('button', ['btn', 'btn-lg', 'btn-toggle']);
            button.setAttribute('type', 'button');
            button.setAttribute('data-toggle', 'button');
            button.setAttribute('aria-pressed', 'false');
            button.setAttribute('autocomplete', 'off');
            var handleDiv = createElement('div', ['handle']);
            button.appendChild(handleDiv);

            button.addEventListener('click', function (event) {
                handleButtonClick(event, this, key);
            });

            return button;
        }

        // Toggle Content 

        function toggleOptionsMachine(element, key) {
            var options = element.parentElement.nextElementSibling;
            options.classList.toggle('show');

            options.querySelectorAll(".detail").forEach(function (option) {
                updateMachineName(option.id);
            });

            var contentParent = element.parentElement;
            contentParent.classList.toggle("active");
        }

        // Button Click Enable/Disable Machine Type 

        function handleButtonClick(event, button, key) {
            event.stopPropagation();
            var confirmChange = window.confirm('Are you sure you want to disable the machine alarm ?');
            if (confirmChange) {
                var isOn = button.classList.contains('active');
                var value = isOn ? '0' : '1';
                var IDEnable = button.previousElementSibling;
                console.log(button); 
                console.log(IDEnable);
                DisableAlarm(IDEnable.id, value, null, function (isSuccess) {
                    if (isSuccess) {
                        var Parameters = key.split('-');
                        LoadDisableAlarm(Parameters[0], Parameters[1], Parameters[2], Parameters[3]);
                    } else {
                        alert('Failed to update alarm status.');
                    }
                });
            }
        }


        // Create content {PFC , Name Signal} by each machine 
        function createOptionsList(values, key, element, ButtonEnable) {
            var optionsList = createElement('div', ['options', 'collapse']);
            var machineContainers = {};

            values.forEach(function (value) {
                var listItem = createOptionListItem(value);
                var machineID = value.MachineID;

                if (!machineContainers[machineID]) {
                    var machineContainer = createMachineContainer(value, key, optionsList, element, ButtonEnable);
                    machineContainers[machineID] = machineContainer;
                    optionsList.appendChild(machineContainer.header);
                    optionsList.appendChild(machineContainer.container);
                }

                machineContainers[machineID].container.appendChild(listItem);
            });

            return optionsList;
        }

        function createOptionListItem(value) {
            var listItem = createElement('div', ['detail']);
            var icon = createElement('i', ['fas', 'fa-icon']);
            listItem.appendChild(icon);

            var textSpan = document.createElement('span');
            textSpan.textContent = value.TagDesc;
            listItem.appendChild(textSpan);

            var SumpfcContainer = createPfcContainer(value);
            listItem.appendChild(SumpfcContainer);

            listItem.setAttribute('id', value.Key);
            listItem.onclick = function () {
                openPopUpSession();
                var textContent = this.querySelector('span').textContent;
                var text_Location = value.FactoryArea + "-" + value.Location + "-" + value.Line;
                ModifyLevel(this.id, textContent, text_Location);
            };

            return listItem;
        }

        function createPfcContainer(value) {
            var SumpfcContainer = createElement('div', ['PFCGroup']);

            for (var i = 1; i <= 4; i++) {
                var pfcContainer = createElement('div');
                var pfcIcon = createElement('i', [getPfcIconClassHeader(i), getPfcIconClass(i), getPfcIconClassPro(i)]);
                pfcIcon.style.color = getPfcclolor(i);
                pfcContainer.appendChild(pfcIcon);

                var pfcText = document.createTextNode(getPfcText(value, i));
                pfcContainer.appendChild(pfcText);
                SumpfcContainer.appendChild(pfcContainer);
            }

            return SumpfcContainer;
        }

        // Create Machine ID Tag

        function createMachineContainer(value, key, optionsList, element, ButtonEnable ) {


            var MachineIDHeader = createElement('div', ['MachineHeader']);
            var textSpan = document.createElement('span');
            textSpan.textContent = value.Machinelabel + " - " + value.MachineID;
            MachineIDHeader.appendChild(textSpan);


            // Create Id for Option and button for Disable alarm  

            element.id = value.MachineType + "-" + value.FactoryArea + "-" + value.Location + "-" + value.Line;
            optionsList.id = value.MachineType + "-" + value.FactoryArea + "-" + value.Location + "-" + value.Line + "_Options";
            ButtonEnable.id = value.MachineType + "-" + value.FactoryArea + "-" + value.Location + "-" + value.Line + "_Button";



            MachineIDHeader.setAttribute('id', value.MachineID);
            MachineIDHeader.addEventListener('click', function () {
                this.classList.toggle('active');
                var Detail = this.nextElementSibling;
                Detail.style.display = Detail.style.display === 'block' ? 'none' : 'block';
            });

            var ButtonEnableMachineId = createButtonEnableForMachineID(value, key, optionsList);
            MachineIDHeader.appendChild(ButtonEnableMachineId);

            var MachineIDContainer = createElement('div', ['machine-container']);
            MachineIDContainer.style.display = 'none';

            return {
                header: MachineIDHeader,
                container: MachineIDContainer
            };
        }

        function createButtonEnableForMachineID(value, key, optionsList) {
            var button = createElement('button', ['btn', 'btn-lg', 'btn-toggle']);
            button.setAttribute('type', 'button');
            button.setAttribute('data-toggle', 'button');
            button.setAttribute('aria-pressed', 'false');
            button.setAttribute('autocomplete', 'off');
            button.setAttribute('id', value.MachineID + '_Button');
            var handleDiv = createElement('div', ['handle']);
            button.appendChild(handleDiv);

            button.addEventListener('click', function (event) {
                handleMachineIDButtonClick(event, this, value, key, optionsList);
            });

            return button;
        }

        // Button Click Enable/Disable Machine by ID 

        function handleMachineIDButtonClick(event, button, value, key, optionsList) {
            event.stopPropagation();
            var confirmChange = window.confirm('Are you sure you want to disable the machine alarm ?');
            if (confirmChange) {
                var isOn = button.classList.contains('active');
                var FlagValue = isOn ? '0' : '1';
                var MachineID = button.parentElement;
                OptionID = optionsList.id.split('_')[0];
                
                DisableAlarm(OptionID, FlagValue, MachineID.id, function (isSuccess) {
                    if (isSuccess) {
                        LoadDisableAlarm(value.MachineType, value.FactoryArea, value.Location, value.Line);
                    } else {
                        alert('Failed to update alarm status.');
                    }
                });
            }
        }

    </script>


    <!--Define Class Case -->

    <script>

        // Function to get PFC icon class dynamically based on index
        function getPfcIconClass(index) {
            switch (index) {
                case 1:
                    return 'fa-square-caret-down'; // Change to the appropriate class for your first icon
                case 2:
                    return 'fa-square-caret-down'; // Change to the appropriate class for your second icon
                case 3:
                    return 'fa-square-caret-up'; // Change to the appropriate class for your third icon
                case 4:
                    return 'fa-square-caret-up'; // Change to the appropriate class for your fourth icon
                default:
                    return "";
            }
        }
       
        function getPfcIconClassHeader(index) {

            switch (index) {
                case 1:
                    return 'fa-solid'; // Change to the appropriate class for your first icon
                case 2:
                    return 'fa-solid'; // Change to the appropriate class for your second icon
                case 3:
                    return 'fa-solid'; // Change to the appropriate class for your third icon
                case 4:
                    return 'fa-solid'; // Change to the appropriate class for your fourth icon
                default:
                    return "";
            }

        }
       
        function getPfcIconClassPro(index) {

            switch (index) {
                case 1:
                    return 'fa-sm'; // Change to the appropriate class for your first icon
                case 2:
                    return 'fa-sm'; // Change to the appropriate class for your second icon
                case 3:
                    return 'fa-sm'; // Change to the appropriate class for your third icon
                case 4:
                    return 'fa-sm'; // Change to the appropriate class for your fourth icon
                default:
                    return "";
            }

        }
        // Function to get PFC text dynamically based on index
        function getPfcText(value, index) {
            switch (index) {
                case 4:
                    return (value.PFC_High + value.Active_HighOffset);
                case 3:
                    return value.PFC_High;
                case 2:
                    return value.PFC_Low;
                case 1:
                    return (value.PFC_Low - value.Active_LowOffset);
                default:
                    return "";
            }
        }

        function getPfcclolor( index) {
            switch (index) {
                case 1:
                    return '#e53415';
                case 2:
                    return '#63E6BE';
                case 3:
                    return '#63E6BE';
                case 4:
                    return '#e53415';
                default:
                    return "";
            }
        }

    </script>

</asp:Content>




