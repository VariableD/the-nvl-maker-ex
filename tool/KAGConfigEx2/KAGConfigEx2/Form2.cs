using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing.Text; //字体读取相关

namespace KAGConfigEx2
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
            button1.DialogResult = DialogResult.OK;
            button2.DialogResult = DialogResult.Cancel;
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            getFontList();
        }

        
        private void getFontList()
        {
            InstalledFontCollection fonts = new InstalledFontCollection();
            listBox1.Items.Clear();

            foreach (FontFamily family in fonts.Families)
            {
                listBox1.Items.Add(family.Name);
            }

            listBox1.SelectedIndex = 0;

        }

        public string font_name
        {
            get { return listBox1.SelectedItem.ToString(); }
        }

        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                Font showFont = new Font(font_name, 16, FontStyle.Regular);
                label1.Font = showFont;
                label2.Font = showFont;
                label3.Font = showFont;
                label4.Font = showFont;
                label5.Font = showFont;
            }
            catch 
            {
                
            }
        }

    }
}
