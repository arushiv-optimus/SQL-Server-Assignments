﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.ComponentModel.DataAnnotations;

namespace WebgridDemoApp.Models
{
    public class EmpModel
    {
        [Key]
        [Display(Name = "EmpID")]
        public int Id { get; set; }

        [Required(ErrorMessage = "First name is required.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "City is required.")]
        public string City { get; set; }

        [Required(ErrorMessage = "Address is required.")]
        public string EmpAddress { get; set; }

    }
}