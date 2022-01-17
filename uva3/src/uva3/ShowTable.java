package uva3;

import javax.swing.*;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.FileOutputStream;
import java.io.IOException;

public class ShowTable extends JFrame 
{
	private static final long serialVersionUID = 1L;
	private JTextField textField;
	private static XSSFWorkbook wb;
	
	public ShowTable()  {
		super("Отображение запроса из БД MySQL");
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		//Arrays.sort(arrayD, Comparator.comparingInt( GetQuery.outDB ->  GetQuery.outDB[0]));
		
	    JTable table1 = new JTable(new MyTableModel());
	    
	    JButton button1 = new JButton("Фильтр");
        button1.setActionCommand("Button 1 was pressed!");
        
        JButton button2 = new JButton("Сортировка");
        button2.setActionCommand("Button 2 was pressed!");
        
        JButton button3 = new JButton("Экспорт в 'out.xlsx' ");
        button3.setActionCommand("Button 3 was pressed!");
        
        button3.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent event) {
            	JOptionPane.showMessageDialog(rootPane, "JButton Pressed");
            }
        });
        
        Box contents = new Box(BoxLayout.Y_AXIS);
		contents.add(new JScrollPane(table1));
		contents.add(button1);
		contents.add(button2);
		contents.add(button3);
		        		
		setContentPane(contents);
		pack();
		setLocationRelativeTo(null);
		setVisible(true);
	}

	
}

