using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Threading;


namespace KAGConfigEx2
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {

            //Uncomment these to test Japanese Localization
            //Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("ja-JP");
            //Thread.CurrentThread.CurrentUICulture = new System.Globalization.CultureInfo("ja-JP");

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1(args));
        }
    }
}
