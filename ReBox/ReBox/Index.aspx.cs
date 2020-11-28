using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReBox
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static string getBinsJson()
        {
            List<RecycleBox> bins = new List<RecycleBox>();
            using (recycleboxEntities dc = new recycleboxEntities())
            {
                bins = dc.RecycleBox.ToList();
            }
            return JsonConvert.SerializeObject(bins);

        }
    }
}