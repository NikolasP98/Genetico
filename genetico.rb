require_relative "apoyo"
aux = Funciones_apoyo.new


class Condiciones
	def initialize (filas, columnas, nganadores)
		@filas = filas
		@columnas = columnas
		@nganadores = nganadores
	end
end

class Genetico < Condiciones
	def initialize (filas, columnas, nganadores)
		super(filas, columnas, nganadores)
	end
	poblacion = [[@filas],[@columnas]]
	poblacionTem = [[@filas],[@columnas]]
	parejas = [@filas]
	ganadores = [@nganadores]
	sumatoria = 0
	
	def inciarPoblacion (poblacion)
		puts "***********************************************************"
		puts "********************Iniciar Poblacion***********************"
		puts "***********************************************************"
		individuo = ""
		for i in (0..parejas.length) do 
			for j in (0..parejas.length-4) do 
				ri = rand(0..1)
				ro = rand(0..1)
				ra = rand(0..1)
				individuo = ""
				individuo ="#{ri.to_i} , #{ro.to_i} , #{ra.to_i} , #{ra.to_i} , #{ra.to_i}" 
				poblacion[[i],[0]] = "#{i}"
				poblacion[[i],[1]] = individuo

			end
			poblacion[[i],[0]] = "#{i}"
			poblacion[[i],[1]] = individuo
		end
	end

	def convertir_individuo (poblacion)
		valor = 0
		for i in (0..parejas.length) do
			valor = 0
			valores[] = poblacion[i][1].split(";")
			indice = 0
			for j in (valores.length-1..0) do
				valor += valores[j].to_f * 2^indice
				indice += 1
			end
		poblacion[i][2] = "#{valor}"
		sumatoria = valor
		end
	end

	def calidad_individuo (poblacion)
		mayor = poblacion[0][2].to_f
		valor = 0
		for i in (0..parejas.length) do 
			valor = aux.function_fx(poblacion[i][2].to_f)
			poblacion [i][3] = "#{valor}"
			if mayor < valor
				mayor = valor
			end
		end
		puts "********************Mejor Adaptado*************************"
		puts "*************************#{mayor}*************************"  
		return mayor     
	end



	def combinacion_mutacion (poblacion , poblacionTem)
		puts "********************Combiancion y Mutacion*****************"
		puts "***********************************************************"
		
		puntocruce = 0
		individuoA = []
		individuoB = []
		parejaA = ""
		for i in (0..parejas.length/2) do
			ri = rand(0..3)
			individuoA = poblacion[i][1].split(",")
			individuoB = poblacion[parejaA.to_i][1].split(",")
			parejaA = parejas[i]
			puntocruce = ri.to_i
			cadAdn = ""

			puts "Punto cruce [#{puntocruce}][#{poblacion[i][0]}]\n[#{poblacion[i][1]}][Cruzado con] [#{poblacion[parejaA.to_i][0]}]\n[#{poblacion[parejaA.to_i][1]}]"
			for t in (0..puntocruce) do
				cadAdn += "#{individuoA[t]},"
			end
			for t in (puntocruce..individuoA.length) do
				cadAdn += "#{individuoB[t]},"
			end
			puts "Nuevo Individuo [#{cadAdn}]"
			poblacionTem[i][0] = "#{i}"
			poblacionTem[i][1] = cadAdn
		end
		for i in (0..parejas.length) do
			poblacion[i][0] = poblacionTem[i][0]
			poblacion[i][1] = poblacionTem[i][1]
		end
		mutado = (parejas.length/2)+1
		individuoA = poblacion[mutado][1].split(",")
		puts "**************************Mutacion********************************"
		puts "****Individuo*****************************Resultado***************"
		ri = rand(0..3)
		gen = ri.to_i
		if individuoA[gen] = 0
			individuoA[gen] = 1
		else
			individuoA = 0
		end
		cadAdn = ""
		for t in (0..individuoA.length)
			cadAdn += "#{individuoA[t]},"
		end
		puts "[#{poblacion[mutado][0]}][#{poblacion[mutado][1]}]\nGen mutado [#{gen}]\nResultado => [#{poblacion[mutado][0]}][#{cadAdn}]"

		poblacion[mutado][1] = cadAdn
	end



	def copiarse (poblacion , poblacionTem)
		puts "********************Copiarse*******************************"
		indice = 0
		t = 0
		for i in (0..ganadores.length) do
			ganador = ganadores[i].to_i
			poblacionTem[indice][0] = "#{i+t}"
			poblacionTem[indice+1][0] = "#{i+1+t}"
			for j in (1..columnas) do
				poblacionTem[indice][f] = poblacion[ganador][f]          
				poblacionTem[indice+1][f] = poblacion[ganador][f]
			end  
			indice += 2
			t += 1  
		end
		for i in (0..parejas.length) do
			poblacion[i][0] = poblacionTem[i][0]
			poblacion[i][1] = poblacionTem[i][1] 
		end   
	end

	def verGanadores (ganadores)
		puts "**************Ganadores********************************"
		gano = 0
		for i in (0..ganadores.length) do 
			gano = ganadores[i].to_i
			puts "[ #{poblacion[gano][0]} ] [ #{poblacion[gano][1]} ] [ #{poblacion[gano][2]} ] [ #{poblacion[gano][3]} ]"
		end
	end
	
	def torneo(poblacion)
		puts "***********************************************************"
		puts "********************Torneo*********************************"
		desempeñoA = ""
		parejaA = ""
		desempeñoB = ""
		indP = 0
		for i in (0..parejas.length) do 
			desempenoA = poblacion[i][3];
			parejaA = parejas[i];          
			desempenoB = poblacion[parejaA.to_i][3];
			puts "[ #{poblacion[i][0]} ] [ #{poblacion[i][1]} ] [ #{poblacion[i][2]} ] [ #{poblacion[i][3]} ]"
			if desempenoA.to_f >= desempenoB.to_f
				ganadores[indP] = poblacion[i][0]
			else
				ganadores[indP] = parejaA
			end
			indP +=1
		end
	end

	def seleccion_parejas (poblacion)
		puts "***********************************************************"
		puts "********************Seleccion Parejas**********************"
		aux = poblacion[1][0]
		for i in (0..parejas.length) do
			parejas[(parejas.length-1)-i]=poblacion[i][0]
		end
	end

	def adaptabilidad (poblacion ,sumatoria)
		for i in (0..parejas.length) do 
			poblacion[i][4] = "#{poblacion[i][2].to_i/sumatoria}"
		end
	end

	def verPoblacion (poblacion , pareja)
		puts "********************Pablacion Actual***********************"
		cadena = ""
		for i in (0..filas) do
			for j in (0..columnas) do
				cadena += "[#{poblacion[i][k]} ]"
			end
			if pareja 
				cadena += "pareja #{parejas[i]} \n"
			else
				cadena += "#{"\n"}"
			end
		end
		puts cadena
	end


	def run ()
		inciarPoblacion(poblacion)
		verPoblacion(poblacion, false)
		adaptados = 0
		while adaptados < 961
			convertir_individuo(poblacion)
			adaptados = calidad_individuo(poblacion)
			adaptabilidad(poblacion, sumatoria)
			verPoblacion(poblacion, true)
			seleccion_parejas(poblacion)
			torneo(poblacion)
			verGanadores(ganadores)
			copiarse(poblacion, poblacionTem)
			verPoblacion(poblacionTem, true)
			seleccion_parejas(poblacion)
			combinacion_mutacion(poblacion, poblacionTem)
		end
		adaptados = calidad_individuo(poblacion)
		verPoblacion(poblacion, false)
	end
end

genetico = Genetico.new(10, 5, 5)

genetico.run()