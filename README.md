# Tetris_FPGA_Digital
Trabajo Digital 2023/24 ETSII UPM
--------------------------------------------------------------------------------------------------------------------
# SEÑALES COMUNES
clk : std_logic;
reset : std_logic;

-- MiPieza

MiPieza_ND : integer; ~ MiPieza_Nivel_Display. [Valores a tomar: 0 (Generacion), 1, 2, 3, 4]

MiPieza_TP : integer; ~ MiPieza_Tipo_Pieza.  [Valores a tomar: 0 a 127]

-- Entorno, displays con piezas fijadas [Valores a tomar: 0 a 127]

E1 : integer; ~ Display primero, aparición pieza 

E2 : **********;  

E3 : **********;

E4 : **********; ~ Display suelo

-- Puntos

puntos : integer; [Valores enteros: 0, 1,...]

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

********_Flag : std:logic;

********_Fin_Flag : std:logic;

--------------------------------------------------------------------------------------------------------------------
# BLOQUES
- Bloque Estructura (main)
- Bloque CONTROL
- Bloque Reloj (con Divisor de frecuencia)
- Bloque Fases (Niveles)
- Bloque Antirrebote
- Bloque Acción (Giros y desplazamientos horizontales)
- Bloque Next (Baja pieza de display)
- Bloque Generacion_Pieza
- Bloque Puntos (Comprobar si Displays Completos, cada vez que se fija pieza)
- Bloques Display [Visualización]
- Bloques LEDs [Visualización]

