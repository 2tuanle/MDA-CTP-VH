using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace MDA_CTP
{
    public partial class SiteMaster : MasterPage
    {
        //public string userLanguage { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if a language parameter is present in the URL
                string lang = Request.QueryString["lang"];

                if (!string.IsNullOrEmpty(lang))
                {
                    // Set the selected language
                    SetCulture(lang);
                }
            }
        }

      

        private void SetCulture(string lang)
        {
            // Set the culture and UI culture based on the selected language
            CultureInfo culture = CultureInfo.CreateSpecificCulture(lang);
            Thread.CurrentThread.CurrentCulture = culture;
            Thread.CurrentThread.CurrentUICulture = culture;

            // Save the selected language to a session variable or cookie for future reference
            Session["Language"] = lang;
            //Response.Redirect(Session["Domain"].ToString());
        }

        [WebMethod(EnableSession = true)]
        public static void ClearSession(string uniqueId)
        {

            var context = HttpContext.Current;
            string sessionKey = $"PreviousStatuses_{uniqueId}";
            if (context.Session[sessionKey] != null)
            {
                context.Session.Remove(sessionKey);
                Debug.WriteLine("Session cleared successfully.");
            }
        }


    }
}