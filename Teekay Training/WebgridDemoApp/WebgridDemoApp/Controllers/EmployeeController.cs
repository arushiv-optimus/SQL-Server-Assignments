using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebgridDemoApp.Models;
using WebgridDemoApp.Repository;

namespace WebgridDemoApp.Controllers
{
    public class EmployeeController : Controller
    {
        // GET: Employee
        public ActionResult Index()
          {
            EmpRepository empRepository = new EmpRepository();
            ModelState.Clear();
             return View(empRepository.GetAllEmployees());
         }

        //Get : Create Employee
        public ActionResult Create()
        {
            return View();
        }

        //Post : Create Employee
        [HttpPost]
        public ActionResult Create(EmpModel emp)
        {
            try { 
                if(ModelState.IsValid)
                {
                    EmpRepository empRepository = new EmpRepository();
                    if(empRepository.AddEmployee(emp))
                    {
                        ViewBag.Message = "Employee details added successfully";
                    }
                }
            return View();
            }
            catch(Exception)
            {
                throw;
            }
        }

        // Get :Edit Employee
        public ActionResult Edit(int id)
        {
            EmpRepository empRepository = new EmpRepository();
            var emp = empRepository.GetAllEmployees().Find(temp => temp.Id == id);
            return View(emp);
        }

        // Post: Edit Employee
        [HttpPost]
        public ActionResult Edit(EmpModel emp)
        {
            try
            {
                if(ModelState.IsValid)
                {
                    EmpRepository empRepository = new EmpRepository();
                    if(empRepository.UpdateeEmployee(emp))
                    {
                        ViewBag.Message = "Employee details added successfully";
                    }
                }
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
                throw;
            }
           
        }



        //Get : Delete Employee
        public ActionResult DeleteEmp(int id)
        {
            try
            {
                EmpRepository empRepository = new EmpRepository();
                if(empRepository.DeleteEmployee(id))
                {
                    ViewBag.AlertMsg = "Employee details deleted successfully";
                }
                return RedirectToAction("Index");
            }
            catch(Exception)
            {
               throw;
            }
        }




    }
}