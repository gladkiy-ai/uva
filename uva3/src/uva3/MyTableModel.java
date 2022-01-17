package uva3;

import javax.swing.table.AbstractTableModel;

public class MyTableModel extends AbstractTableModel{

    public int getRowCount() {
        return GetQuery.outDB[0].length;
    }

    public int getColumnCount() {
        return GetQuery.outDB.length;
      }

    public Object getValueAt(int r, int c) {
    	return GetQuery.outDB[c][r];
    }

    public String getColumnName(int c) {
        switch (c) {
            case 0:
                return "employee";
            case 1:
                return "salary";
            case 2:
                return "department";
            case 3:
                return "chief";
            default:
                return "chief's salary";
                }
    }
}
