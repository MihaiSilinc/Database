using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace lb1db
{
    public partial class Form1 : Form
    {
        /*
    <add key="parentTable" value="Bank" />
    <add key="childTable" value="BankBranch" />
    <add key="parentTableId" value="BankId" />
    
    <add key="parentTable" value="Customer" />
    <add key="childTable" value="Loan" />
    <add key="parentTableId" value="CustomerId" />
         */
        private string parentTable;
        private string childTable;
        private string parentTableId;
        private SqlConnection conn;
        private DataSet ds;
        private SqlDataAdapter daParentTable, daChildTable;
        private SqlCommandBuilder cbChildTable;
        private BindingSource bsParentTable, bsChildTable;


        private void Form1_Load(object sender, EventArgs e)
        {
            parentTable = ConfigurationManager.AppSettings.Get("parentTable");
            childTable = ConfigurationManager.AppSettings.Get("childTable");
            parentTableId = ConfigurationManager.AppSettings.Get("parentTableId");
            conn = new SqlConnection(@"Data Source = MSVDESKTOP; Initial Catalog = Banking System; Integrated Security = SSPI");
            ds = new DataSet();
            daParentTable = new SqlDataAdapter("SELECT * FROM " + parentTable, conn);
            daChildTable = new SqlDataAdapter("SELECT * FROM " + childTable, conn);
            cbChildTable = new SqlCommandBuilder(daChildTable);
            daParentTable.Fill(ds, parentTable);
            daChildTable.Fill(ds, childTable);

            var fkConstraint = $"FK_{parentTable}_{childTable}";

            var dr = new DataRelation(fkConstraint, ds.Tables[parentTable].Columns[parentTableId],
                ds.Tables[childTable].Columns[parentTableId]);
            ds.Relations.Add(dr);

            bsParentTable = new BindingSource { DataSource = ds, DataMember = parentTable };

            bsChildTable = new BindingSource { DataSource = bsParentTable, DataMember = fkConstraint };

            dgvShips.DataSource = bsParentTable;
            dgvPirates.DataSource = bsChildTable;

            //go
            //select @SERVERNAME
        }

        private void updateButton_Click(object sender, EventArgs e)
        {
            daChildTable.Update(ds, childTable);
        }

        public Form1()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

    }
}
