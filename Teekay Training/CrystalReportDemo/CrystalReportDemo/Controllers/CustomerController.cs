using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CrystalReportDemo.Controllers
{
    public class CustomerController : Controller
    {
        //DbContext  
        TeekayTrainingEntities context = new TeekayTrainingEntities();
        // GET: Customer
        public ActionResult Index()
        {
            var customerList = context.Customers.ToList();
            return View(customerList);
        }

        public ActionResult ExportCustomers()
        {
            List<Customer> allCustomer = new List<Customer>();
            allCustomer = context.Customers.ToList();

            ReportDocument reportDocument = new ReportDocument();
            reportDocument.Load(Path.Combine(Server.MapPath("~/CrystalReport"), "CrystalReport.rpt"));

            reportDocument.SetDataSource(allCustomer);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();

            Stream stream = reportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "CustomerList.pdf");
        }

        public ActionResult EmployeeReport()
        {
            var employeeList = context.Employees1.ToList();
            return View(employeeList);
        }

        public ActionResult Details(int id)
        {
            try
            { 

            var employeeDetail = context.EmployeeDeatils(id);

            List<EmployeeDeatils_Result> employeeDetails = new List<EmployeeDeatils_Result>();
            employeeDetails = context.EmployeeDeatils(id).ToList();

            ReportDocument reportDocument = new ReportDocument();
            reportDocument.Load(Path.Combine(Server.MapPath("~/CrystalReport"), "EmployeeReport.rpt"));

            reportDocument.SetDataSource(employeeDetails);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();

            Stream stream = reportDocument.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);

            return File(stream, "application/pdf", "EmployeeDetail.pdf");

            }
            catch (Exception ex)
            {
                throw;
            }
        }

    }
}