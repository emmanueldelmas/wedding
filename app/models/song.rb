# coding: utf-8

class Song
  
  SONGS = [
    {id: 0, name: "", title: "", type: "Procession", author: ""},
    {id: 1, name: "", title: "", type: "Louange d'entrée", author: ""},
    {id: 2, name: "", title: "", type: "Kyrie", author: ""},
    {id: 3, name: "", title: "", type: "Gloria", author: ""},
    {id: 4, name: "", title: "", type: "Psaume", author: ""},
    {id: 5, name: "", title: "", type: "Alleluia", author: ""},
    {id: 6, name: "", title: "", type: "Action de grâce", author: ""},
    {id: 7, name: "", title: "", type: "Invocation à l'Esprit", author: ""},
    {id: 8, name: "", title: "", type: "Prière universelle", author: ""},
    {id: 9, name: "ne_crains_pas", title: "Ne crains pas, Je suis ton Dieu", type: "Offertoire", author: ""},
    {id: 10, name: "", title: "", type: "Sanctus", author: ""},
    {id: 11, name: "", title: "", type: "Anamnèse", author: ""},
    {id: 12, name: "", title: "", type: "Agnus", author: ""},
    {id: 13, name: "", title: "", type: "Communion", author: ""},
    {id: 14, name: "", title: "", type: "Louange finale", author: ""},
  ]

  def self.find(id)
  	SONGS[id]
  end

end
