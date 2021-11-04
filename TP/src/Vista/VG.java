package Vista;

import java.awt.Color;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import codigo.Lexico;
import codigo.Simbolos;
import codigo.parser;

import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.JFileChooser;

import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.awt.event.ActionEvent;


public class VG {

	private JFrame frmTeoGrupo;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					VG window = new VG();
					window.frmTeoGrupo.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public VG() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frmTeoGrupo = new JFrame();
		frmTeoGrupo.setTitle("TEO1 - GRUPO 4");
		frmTeoGrupo.setResizable(false);
		frmTeoGrupo.setBounds(100, 100, 1050, 571);
		frmTeoGrupo.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frmTeoGrupo.getContentPane().setLayout(null);
		
		JScrollPane scrollPane = new JScrollPane();
		scrollPane.setBounds(22, 111, 485, 371);
		frmTeoGrupo.getContentPane().add(scrollPane);
		
		JTextArea codigo = new JTextArea();
		scrollPane.setViewportView(codigo);
		codigo.setAutoscrolls(true);
		JLabel lblNewLabel = new JLabel("Codigo");
		scrollPane.setColumnHeaderView(lblNewLabel);
		
		JScrollPane scrollPane_1 = new JScrollPane();
		scrollPane_1.setBounds(531, 111, 476, 371);
		frmTeoGrupo.getContentPane().add(scrollPane_1);
		
		JTextArea salida = new JTextArea();
		salida.setEditable(false);
		scrollPane_1.setViewportView(salida);
		salida.setAutoscrolls(true);
		
		JLabel lblNewLabel_1 = new JLabel("salida");
		scrollPane_1.setColumnHeaderView(lblNewLabel_1);
		
		JButton btnNewButton = new JButton("Cargar Archivo");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				JFileChooser fc = new JFileChooser();
				File workingDirectory = new File(System.getProperty("user.dir"));
				fc.setCurrentDirectory(workingDirectory);
				int returnVal = fc.showOpenDialog(frmTeoGrupo);
				if (returnVal == JFileChooser.APPROVE_OPTION) {
					File file = fc.getSelectedFile();	
					codigo.setText("");
					salida.setText("");
					try {
						String s =  file.getPath();
						FileReader f = new FileReader(s);
						BufferedReader br = new BufferedReader(f);
						String line,t;
						t="";
						while((line = br.readLine()) != null){
							t+=line +  "\r\n";
						}
						br.close();
						codigo.setText(t);
					} catch (IOException ex) {
						// TODO Auto-generated catch block
						ex.printStackTrace();
					}
				}
			}
		});
		btnNewButton.setBounds(131, 46, 161, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton);
		
		JButton btnNewButton_1 = new JButton("Compilar");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				salida.setText("");
				String cod = codigo.getText();
				FileWriter fw;
				try {
					fw = new FileWriter("codigo.txt");
					fw.write(cod);
					fw.close();
				} catch (IOException ex) {
					// TODO Auto-generated catch block
					ex.printStackTrace();
				}
				
				try {
					FileReader f = new FileReader("codigo.txt");
					Lexico lex = new Lexico(f);
					parser sintac = new parser(lex);
					try {
						sintac.parse();
						if (sintac.getError().size()>0) {
							String s="ERRORES \n";
							for(String er:sintac.getError()) {
								s+=er+"\n";
							}
							salida.setForeground(Color.RED);
							salida.setText(s);
						} else {
							salida.setForeground(Color.BLACK);
							salida.setText(sintac.getReglas());
							try {
								fw = new FileWriter("ts.txt");
								fw.write("NOMBRE | TOKEN | TIPO | VALOR | LONG \n");
								for (Simbolos si:sintac.getSimbolos()) {
									fw.write(si.toString());
								}
								fw.close();
							} catch (IOException ex) {
								// TODO Auto-generated catch block
								ex.printStackTrace();
							}
						}
						
					} catch (Exception ex) {
						// TODO Auto-generated catch block
						ex.printStackTrace();
					}
				} catch (IOException ex) {
					// TODO Auto-generated catch block
					ex.printStackTrace();
				}
				
				}	
			
		});
		btnNewButton_1.setBounds(494, 46, 89, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton_1);
		
		JButton btnNewButton_2 = new JButton("Guardar codigo");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				String cod = codigo.getText();
				FileWriter fw;
				JFileChooser fc = new JFileChooser();
				File workingDirectory = new File(System.getProperty("user.dir"));
				fc.setCurrentDirectory(workingDirectory);
				int returnVal = fc.showSaveDialog(frmTeoGrupo);
				if (returnVal == JFileChooser.APPROVE_OPTION) {
					File file = fc.getSelectedFile();	
					try {
						String s =  file.getPath();
						fw = new FileWriter(s);
						fw.write(cod);
						fw.close();
					} catch (IOException ex) {
						// TODO Auto-generated catch block
						ex.printStackTrace();
					}
				}
				
			}
		});
		btnNewButton_2.setBounds(693, 46, 175, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton_2);
	}

}
