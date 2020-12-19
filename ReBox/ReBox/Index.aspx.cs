using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace ReBox
{
    public partial class Index : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public static string getBinsJson()
        {        
            string recycleboxEntities = ConfigurationManager.ConnectionStrings["recycleboxEntities"].ConnectionString;

            List<recycleboxEntities> bins = new List<recycleboxEntities>();

            using (SqlConnection con = new SqlConnection(recycleboxEntities))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM dbo.ReBox"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (RecycleBox dt = new RecycleBox())
                        {
                            bins = (from item in dt.AsEnumerable()
                                    select new RecycleBox()
                                    {
                                        idlocation = (int)item["id_location"],
                                        longitude = (float)item["longitude"],
                                    }
                        ).ToList();
                        }
                    }
                }
            }


            return JsonConvert.SerializeObject(bins); 


        }
    }
}