using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using WebgridDemoApp.Models;

namespace WebgridDemoApp.Repository
{
    public class EmpRepository
    {
        private SqlConnection con;

        //To Handle conncetiion related activity
        private void connection()
        {
            string constr = ConfigurationManager.ConnectionStrings["getconn"].ToString();
            con = new SqlConnection(constr);
        }

        //to Add Employee details
        public bool AddEmployee(EmpModel obj)
        {
            connection();
            SqlCommand com = new SqlCommand("AddNewEmpDetails", con);
            com.CommandType = CommandType.StoredProcedure;

            com.Parameters.AddWithValue("@name", obj.Name);
            com.Parameters.AddWithValue("@city", obj.City);
            com.Parameters.AddWithValue("@empAddress", obj.EmpAddress);

            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if(i>=1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //To view employee details with generic list
        public List<EmpModel> GetAllEmployees()
        {
            connection();
            List<EmpModel> EmpList = new List<EmpModel>();

            SqlCommand com = new SqlCommand("GetEmployees", con);
            com.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            da.SelectCommand = com;
            DataTable dt = new DataTable();
           // DataSet ds = new DataSet();

            con.Open();
            da.Fill(dt);
            //da.Fill(ds);
            con.Close();

            //Bind EmpModel generic list using dataRow
            foreach(DataRow dr in dt.Rows)
            {
                EmpList.Add(
                    new EmpModel
                    {
                        Id = Convert.ToInt32(dr["Id"]),
                        Name = Convert.ToString(dr["Name"]),
                        City = Convert.ToString(dr["City"]),
                        EmpAddress = Convert.ToString(dr["EmpAddress"])

                    }
                    );
            }

            return EmpList;

        }

        //To Update Employee details  
        public bool UpdateeEmployee(EmpModel obj)
        {
            connection();
            SqlCommand com = new SqlCommand("UpdateEmpDetails", con);

            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@empId", obj.Id);
            com.Parameters.AddWithValue("@name", obj.Name);
            com.Parameters.AddWithValue("@city", obj.City);
            com.Parameters.AddWithValue("@empAddress", obj.EmpAddress);

            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close(); 
            if(i>=1)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        //To delete Employee details

        public bool DeleteEmployee(int Id)
        {

            connection();
            SqlCommand com = new SqlCommand("DeleteEmpById", con);

            com.CommandType = CommandType.StoredProcedure;
            com.Parameters.AddWithValue("@EmpId", Id);

            con.Open();
            int i = com.ExecuteNonQuery();
            con.Close();
            if (i >= 1)
            {

                return true;

            }
            else
            {

                return false;
            }

        }

    }
}