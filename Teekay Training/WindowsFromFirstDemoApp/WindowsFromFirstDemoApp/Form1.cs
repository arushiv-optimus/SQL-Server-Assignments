using System;
using System.Windows.Forms;

namespace WindowsFromFirstDemoApp
{
    public partial class Form1 : Form
    {
        public static string SetValueForText1 = "";

        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void btnSubmint_Click(object sender, EventArgs e)
        {
            SetValueForText1 = txtName.Text;
            this.Hide();
            Form2 F2 = new Form2();
            F2.Show();
        }
    }
}
