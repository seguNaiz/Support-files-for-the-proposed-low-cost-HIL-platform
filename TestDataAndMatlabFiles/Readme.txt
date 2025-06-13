Aqui hay resultados de 3 test:

1- Efecto Regenerativo y Herramienta en ZedBoard(FPGA). Se conectan entre si por medio de los ADC/DAC (PMOD).
	Contiene los ficheros: (los datos se obtienen mediante ficheros guardados en el micro, por lo que pasan a traves de los AXI antes de guardarse).
	a) ZedBoardFeed_RegEff. Son los datos de salida del Efecto regenerativo 

2- Efecto Regenerativo y Herramienta en PC de tiempo-real. Se conectan entre si por medio de AI/AO.
	Contiene los ficheros:
	a) RtFeed_RegEff. Contiene los datos de salida del Efecto regenerativo y la lectura de la posicion de la herramienta (lo que seria el laser).
	b) RtFeed_Tool. Contiene los datos de salida de la posición de la herramienta (lo que seria el laser) y la lectura de lo que seria el shaker (Efecto regenerativo).

3- Efecto Regenerativo ZedBoard(FPGA) y Herramienta en PC de tiempo-real. Se conectan entre si por medio de los ADC/DAC (PMOD) conectados a la Zedboard y las AI/AO conectadas al PC RT.
	Contiene los ficheros:
	a) cosimZedB_RegEff. Datos sacados de ficheros del micro de la ZedBoard. Contiene los datos de salida del Efecto regenerativo (shaker) y la lectura de la posicion de la herramienta (lo que seria el laser).
	b) cosimPcRt_Tool. Datos sacados del PC de tiempo real. Contiene los datos de salida de la posición de la herramienta (lo que seria el laser) y la lectura de lo que seria el shaker (Efecto regenerativo).

----------------------------------------------

Here are the results from 3 tests:

1- Regenerative Effect and Tool on ZedBoard (FPGA). They are connected via ADC/DAC (PMOD).
Contains the files: (the data is obtained through files stored in the microcontroller, so they go through the AXI before being saved).
a) ZedBoardFeed_RegEff. These are the output data from the Regenerative Effect.

2- Regenerative Effect and Tool on Real-Time PC. They are connected via AI/AO.
Contains the files:
a) RtFeed_RegEff. Contains the output data from the Regenerative Effect and the reading of the tool position (which would be the laser).
b) RtFeed_Tool. Contains the output data of the tool position (which would be the laser) and the reading of what would be the shaker (Regenerative Effect).

3- Regenerative Effect on ZedBoard (FPGA) and Tool on Real-Time PC. They are connected via ADC/DAC (PMOD) connected to the ZedBoard and AI/AO connected to the RT PC.
Contains the files:
a) cosimZedB_RegEff. Data extracted from files on the ZedBoard microcontroller. Contains the output data from the Regenerative Effect (shaker) and the reading of the tool position (which would be the laser).
b) cosimPcRt_Tool. Data extracted from the real-time PC. Contains the output data of the tool position (which would be the laser) and the reading of what would be the shaker (Regenerative Effect).