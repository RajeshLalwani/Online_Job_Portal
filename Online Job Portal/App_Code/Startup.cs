using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Online_Job_Portal.Startup))]
namespace Online_Job_Portal
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
