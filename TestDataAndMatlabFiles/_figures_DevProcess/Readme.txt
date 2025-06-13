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