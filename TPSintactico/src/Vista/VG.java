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
	private VTS windTS = new VTS();

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
		
		NumeroLinea numerolinea;
		numerolinea = new NumeroLinea(codigo);
		scrollPane.setRowHeaderView(numerolinea);
		
		JButton btnNewButton = new JButton("Cargar Archivo");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				
				JFileChooser fc = new JFileChooser();
				File workingDirectory = new File(System.getProperty("user.dir"));
				fc.setCurrentDirectory(workingDirectory);
				int returnVal = fc.showOpenDialog(frmTeoGrupo);
				//Opcion para que el usuario elija el archivo a trabajar
				if (returnVal == JFileChooser.APPROVE_OPTION) {
					File file = fc.getSelectedFile();	
					//Limpieza de la JtextArea
					codigo.setText("");
					salida.setText("");
					try {
						//almacena el path del archivo
						String s =  file.getPath();
						FileReader f = new FileReader(s);
						//carga buffer
						BufferedReader br = new BufferedReader(f);
						String line,t;
						t="";
						//arma string a moswtrar en codigo
						while((line = br.readLine()) != null){
							t+=line +  "\r\n";
						}
						br.close();
						//muestra codigo
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
				//limpia salida
				salida.setText("");
				//almacena el codigo escrio en cod
				String cod = codigo.getText();
				FileWriter fw;
				try {
					//almacena el codigo en otro txt
					fw = new FileWriter("codigo.txt");
					fw.write(cod);
					fw.close();
				} catch (IOException ex) {
					// TODO Auto-generated catch block
					ex.printStackTrace();
				}
				
				try {
					//Lee el archivo codigo
					FileReader f = new FileReader("codigo.txt");
					Lexico lex = new Lexico(f);
					parser sintac = new parser(lex);
					try {
						//parsing
						sintac.parse();
						//controla si hay hay algun error
						if (sintac.getError().size()>0) {
							String s="ERRORES \n";
							for(String er:sintac.getError()) {
								s+=er+"\n";
							}
							//muestra los errores
							salida.setForeground(Color.RED);
							salida.setText(s);
						} else {
							//muestra las reglas por las que paso
							salida.setForeground(Color.BLACK);
							salida.setText(sintac.getReglas());
							try {
								//crea la Tabla de simbolos
								fw = new FileWriter("ts.txt");
								//alamena las cabeceras
								fw.write("NOMBRE | TOKEN | TIPO | VALOR | LONG \n");
								//guarda todos los simbolos
								for (Simbolos si:sintac.getSimbolos()) {
									fw.write(si.toString());
								}
								fw.close();
								//muestra los simbolos en otra ventana
								windTS.mostrarTS(sintac.getSimbolos());
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
		btnNewButton_1.setBounds(359, 46, 89, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton_1);
		
		JButton btnNewButton_2 = new JButton("Guardar codigo");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				//lee el codigo escrito
				String cod = codigo.getText();
				FileWriter fw;
				JFileChooser fc = new JFileChooser();
				File workingDirectory = new File(System.getProperty("user.dir"));
				//inicia en la ubicacion actual
				fc.setCurrentDirectory(workingDirectory);
				//dialogo de guardado
				int returnVal = fc.showSaveDialog(frmTeoGrupo);
				if (returnVal == JFileChooser.APPROVE_OPTION) {
					File file = fc.getSelectedFile();	
					try {
						//escribe en el archivo
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
		btnNewButton_2.setBounds(496, 46, 175, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton_2);
		
		JButton btnNewButton_3 = new JButton("Mostrar TS");
		btnNewButton_3.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				// llama a la ventana de tabla de simbolos
				windTS.mostrar();
			}
		});
		btnNewButton_3.setBounds(761, 46, 184, 23);
		frmTeoGrupo.getContentPane().add(btnNewButton_3);
	}
}
