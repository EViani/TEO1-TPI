package Vista;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.awt.event.ActionEvent;
import codigo.Simbolos;


public class VTS {

	private JFrame frmTablaDeSimbolos;
	private JTable tSimbolo;

	/**
	 * Create the application.
	 */
	public VTS() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmTablaDeSimbolos = new JFrame();
		frmTablaDeSimbolos.setResizable(false);
		frmTablaDeSimbolos.setTitle("Tabla de Simbolos");
		frmTablaDeSimbolos.setBounds(100, 100, 673, 374);
		frmTablaDeSimbolos.setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
		frmTablaDeSimbolos.getContentPane().setLayout(null);
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setEnabled(false);
		scrollPane.setBounds(10, 0, 647, 337);
		frmTablaDeSimbolos.getContentPane().add(scrollPane);
		
		DefaultTableModel mTSimbolo = new DefaultTableModel();
		tSimbolo = new JTable(mTSimbolo);
		tSimbolo.setEnabled(false);
		mTSimbolo.addColumn("NOMBRE");
		mTSimbolo.addColumn("TOKEN");
		mTSimbolo.addColumn("TIPO");
		mTSimbolo.addColumn("VALOR");
		mTSimbolo.addColumn("LONG");
		scrollPane.setViewportView(tSimbolo);
		
	}
	
	public void mostrarTS(ArrayList<Simbolos> sim) {
		DefaultTableModel modelo;
		modelo = (DefaultTableModel) tSimbolo.getModel();
		modelo.setRowCount(sim.size());
		Object [] fila = new Object[5];
		int row=0;
		modelo.addRow(fila);
		for(Simbolos s:sim ) {
			modelo.setValueAt(s.getNombre(),row,0);
			modelo.setValueAt(s.getToken(),row,1);
			modelo.setValueAt(s.getTipo(),row,2);
			modelo.setValueAt(s.getValor(),row,3);
			modelo.setValueAt(s.getLongitud(),row,4);
			row++;
		}
		this.frmTablaDeSimbolos.setVisible(true);
	}
	
	public void mostrar() {
		this.frmTablaDeSimbolos.setVisible(true);
	}
}
