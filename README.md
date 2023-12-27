# Tetris_FPGA_Digital
Trabajo Digital 2023/24 ETSII UPM
--------------------------------------------------------------------------------------------------------------------
# SEÑALES COMUNES
clk : std_logic;
reset : std_logic;

-- MiPieza

MiPieza_ND : unsigned(2 downto 0); ~ MiPieza_Nivel_Display. [Valores a tomar: 0 (Generacion), 1, 2, 3, 4]

MiPieza_TP : unsigned(6 downto 0); ~ MiPieza_Tipo_Pieza.  [Valores a tomar: 0 a 127]

-- Entorno, displays con piezas fijadas [Valores a tomar: 0 a 127]

E1 : unsigned(6 downto 0); ~ Display primero, aparición pieza 

E2 : unsigned(6 downto 0);  

E3 : unsigned(6 downto 0);

E4 : unsigned(6 downto 0); ~ Display suelo

-- Puntos

puntos : unsigned(6 downto 0); [Valores enteros: 0, 1,...]

-- Señal Botones (Con rebotes)

B_pausa : std_logic;

B_start_resume :  std_logic;  ***Influye en codigo estructura

B_reset :  std_logic; 

B_m_dcha : std_logic;

B_m_izq : std_logic;

B_g_dcha : std_logic;

B_g_izq : std_logic;


-- Señal Botones Filtradas (Sin rebotes)

Pausa : std_logic;

Start_Resume : std_logic;

Reset_juego : std_logic;

M_dcha : std_logic;

M_izq : std_logic;

G_dcha : std_logic;

G_izq : std_logic;

--FLAGSs

Generacion_pieza_flag : std:logic; --Bloque_Aleatorio

Generacion_pieza_fin_flag : std:logic; --Bloque_Aleatorio

Next_Flag : std:logic; --Bloque_Next

PiezaFijada_Flag : std:logic; --Bloque_Next

PiezaBajada_Flag : std:logic; --Bloque_Next

PiezaBajada_Flag : std:logic; --Bloque_Next

NoActua_Flag : std:logic; --Bloque_Next

********_Fin_Flag : std:logic;

--------------------------------------------------------------------------------------------------------------------
# BLOQUES
- Bloque Estructura (main) Mila
- Bloque CONTROL Leyre
- Bloque Reloj (con Divisor de frecuencia) Lorena
- Bloque Fases (Niveles) Leyre
- Bloque Antirrebote Mila
- Bloque Acción (Giros y desplazamientos horizontales) --Reloj_Juego Carlos
- Bloque Next (Baja pieza de display) --Reloj_Juego Carlos
- Bloque Generacion_Pieza Carlos
- Bloque Puntos (Comprobar si Displays Completos, cada vez que se fija pieza) Carlo
- Bloques Display [Visualización] Lorena
- Bloques LEDs [Visualización] Lorena

