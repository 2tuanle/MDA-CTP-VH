using Microsoft.Owin;
using Owin;
using System.Web.Services.Description;

[assembly: OwinStartup(typeof(MDA.Startup))]

namespace MDA
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            
            app.MapSignalR();
        }
    }
}
