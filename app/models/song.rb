# coding: utf-8

class Song
  
  SONGS = [
    {id: 0, name: "sarabande", title: "Sarabande, marche Nuptial", type: "Procession", author: "Heandel"}.freeze,
    {id: 1, name: "jubilez", title: "Jubilez", type: "Louange d'entrée", author: "Frère Jean-Baptiste"}.freeze,
    {id: 2, name: "kyrie", title: "Messe de l'Emmanuel - Kyrie", type: "Kyrie", author: "Communauté de l'Emmanuel"}.freeze,
    {id: 3, name: "gloria", title: "Messe de l'Emmanuel - Gloria", type: "Gloria", author: "Communauté de l'Emmanuel"}.freeze,
    {id: 4, name: "psaume", title: "Le Seigneur est ma Lumière et mon Salut", type: "Psaume", author: ""}.freeze,
    {id: 5, name: "alleluia", title: "Messe de l'Emmanuel - Alleluia", type: "Alleluia", author: "Communauté de l'Emmanuel"}.freeze,
    {id: 5, name: "litanie", title: "Litanie des saints Congolaise", type: "Litanie des saints", author: "Communauté du Chemin Neuf"}.freeze,
    # {id: 6, name: "", title: "", type: "Action de grâce", author: ""}.freeze,
    # {id: 7, name: "", title: "", type: "Invocation à l'Esprit", author: ""}.freeze,
    {id: 8, name: "mendiez", title: "Mendiez l'humilité", type: "Prière universelle", author: ""}.freeze,
    {id: 9, name: "ne_crains_pas", title: "Ne crains pas, Je suis ton Dieu", type: "Offertoire", author: "Frère Jean-Baptiste"}.freeze,
    {id: 10, name: "sanctus", title: "Messe de l'Emmanuel - Sanctus", type: "Sanctus", author: "Communauté de l'Emmanuel"}.freeze,
    {id: 11, name: "anamnese", title: "Messe de l'Emmanuel - Anamnèse", type: "Anamnèse", author: "Communauté de l'Emmanuel"}.freeze,
    {id: 12, name: "agnus", title: "Messe de l'Emmanuel - Agnus", type: "Agnus", author: "Communauté de l'Emmanuel"}.freeze,
    # {id: 13, name: "", title: "", type: "Communion", author: ""}.freeze,
    # {id: 14, name: "chant_promesse", title: "Chant de la promesse", type: "Promesse scout", author: "Père Jacques Sevin"}.freeze,
    # {id: 14, name: "", title: "", type: "Louange finale", author: ""}.freeze,
  ].freeze

  def self.all
  	SONGS
  end

  def self.find(id)
  	SONGS[id]
  end

end
