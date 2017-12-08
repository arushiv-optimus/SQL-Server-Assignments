using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Windows.Forms;

namespace WindowsFromFirstDemoApp
{
    public partial class Form2 : Form
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da;
        DataSet ds;

        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {

            label1.Text = "Welcome "+ Form1.SetValueForText1 +"...";

            BindGridWithSP();

        }


        private void BindGridWithSP()
        {

            try
            {
                con.Open();
                da = new SqlDataAdapter("SelectAllEmployee", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                ds = new DataSet();
                da.Fill(ds);
                dataGridView1.DataSource = ds.Tables[0].DefaultView; ;
                this.dataGridView1.AllowUserToAddRows = false;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        private void fillToolStripButton_Click(object sender, EventArgs e)
        {
            try
            {
                this.employeeTableAdapter.Fill(this.teekayTrainingDataSet.Employee);
            }
            catch (System.Exception ex)
            {
                System.Windows.Forms.MessageBox.Show(ex.Message);
            }

        }
    }
}
