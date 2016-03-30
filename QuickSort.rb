=begin
Lyhyt koodipätkä pikalajittelun toteuttamiseksi.
Kirjoita aluksi mielivaltaisia kokonaislukuja csv-tiedostoon allekain, ilman välilyöntejä tai muita merkkejä.
Kirjoita tiedostopolku muuttujaan "tiedosto".
Valitse kommenttimerkkejä (#) lisäämällä ja poistamalla pivotarvon valintatapa seuraavista vaihtoehdoista:
Pivotiksi keskimmäinen luku: pivot_index = (array.length / 2).to_i
Pivotiksi ensimmäinen luku: pivot_index = (0).to_i
Pivotiksi viimeinen luku: pivot_index = (array.length - 1).to_i
Pivotiksi satunnainen luku: pivot_index = (rand(0..(array.length - 1))).to_i
=end

#Tähän polku numerotiedostoon
tiedosto = 'numbers.csv'

#Funktio pikalajittelun suorittamiseksi
def quicksort(array)
  return array if array.length <= 1

  #Valitse pivotarvon valintatapa
  pivot_index = (array.length / 2).to_i
  #pivot_index = (0).to_i
  #pivot_index = (array.length - 1).to_i
  #pivot_index = (rand(0..(array.length - 1))).to_i

  #Haetaan halutun pivotindeksin mukainen arvo
  pivot_arvo = array[pivot_index]
  #Pivotarvo on tallessa ja se tulee poistaa työstettävästä taulukosta
  array.delete_at(pivot_index)

  #Pivotin molemmille puolille tarvitaan taulukot pienempiä ja isompia varten
  pienemmat = Array.new
  isommat = Array.new

  #Iteroimalla läpi taulukon käsitellään kukin arvo suhteessa pivotarvoon 
  array.each do |vuorossaoleva|
  	#Jos vuorossa oleva arvo on pienempi kuin pivot, niin se menee pienempien taulukkoon 
    if vuorossaoleva <= pivot_arvo
      pienemmat << vuorossaoleva
    else
    #Jos vuorossa oleva arvo on suurempi kuin pivot, niin se menee suurempien taulukkoon	
      isommat << vuorossaoleva
    end
  end
  #Lopulta palautetaan tulos, jossa pivot on keskellä, pienemmät järjestyksessä sen vasemmalla ja
  #isommat sen oikealla puolella. Koska quicksortia kutsutaan rekursiivisesti, pilkkoontuu
  #alkuperäinen taulukko aina pienempiin osiin, mutta lopulta yhdistyy yhdeksi kokonaisuudeksi
  return quicksort(pienemmat) + [pivot_arvo] + quicksort(isommat)
end

#Otetaan Rubyn csv-ominaisuudet käyttöön
require 'csv'
#Luodaan aputaulukko
taulukko = []
#Luetaan numerotiedostosta jokainen rivi, muunnetaan stringinä olevat arvot numeerisiksi
#ja jokaisella kierroksella lisätään arvo aputaulukkoon
CSV.foreach(tiedosto, converters: :numeric) {|row| taulukko << row[0]}
puts "Pikalajittelulla käsitelty taulukko"
#kutsutaan quicksortia kerätyillä arvoilla, siirretään tulos muuttuujaan "lopullinen"
#palautetaan se tulostusvirtaan
lopullinen = quicksort(taulukko)
p lopullinen
