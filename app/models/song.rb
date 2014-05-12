# coding: utf-8

class Song
	attr_reader :id, :name, :title, :type, :author
  
	def initialize(id, name, title, type, author)
		@id = id
		@name = name
		@title = title
		@type = type
		@author = author
	end

  SONGS = [
    nil,# Song.new(0, "sarabande", "Sarabande, marche Nuptial", "Procession", "Heandel"),
    Song.new(1, "jubilez", "Jubilez", "Louange d'entrée", "Frère Jean-Baptiste"),
    Song.new(2, "kyrie", "Messe de l'Emmanuel - Kyrie", "Kyrie", "Communauté de l'Emmanuel"),
    Song.new(3, "gloria", "Messe de l'Emmanuel - Gloria", "Gloria", "Communauté de l'Emmanuel"),
    Song.new(4, "psaume", "Le Seigneur est ma Lumière et mon Salut", "Psaume", ""),
    Song.new(5, "alleluia", "Messe de l'Emmanuel - Alleluia", "Alleluia", "Communauté de l'Emmanuel"),
    Song.new(5, "litanie", "Litanie des saints Congolaise", "Litanie des saints", "Communauté du Chemin Neuf"),
    nil,# Song.new(6, "", "", "Action de grâce", ""),
    nil,# Song.new(7, "", "", "Invocation à l'Esprit", ""),
    Song.new(8, "mendiez", "Mendiez l'humilité", "Prière universelle", ""),
    Song.new(9, "ne_crains_pas", "Ne crains pas, Je suis ton Dieu", "Offertoire", "Frère Jean-Baptiste"),
    Song.new(10, "sanctus", "Messe de l'Emmanuel - Sanctus", "Sanctus", "Communauté de l'Emmanuel"),
    Song.new(11, "anamnese", "Messe de l'Emmanuel - Anamnèse", "Anamnèse", "Communauté de l'Emmanuel"),
    Song.new(12, "agnus", "Messe de l'Emmanuel - Agnus", "Agnus", "Communauté de l'Emmanuel"),
    Song.new(13, "tu_fais_ta_demeure_en_nous", "Tu fais ta demeure en nous", "Communion", ""),
    Song.new(14, "chant_promesse", "Chant de la promesse", "Promesse scout", "Père Jacques Sevin"),
    nil,# Song.new(14, "", "", "Louange finale", ""),
  ].freeze

  def self.all;  	SONGS.compact;  end
  def self.find(id);  	SONGS[id];  end

  def self.welcome_song;    find(9);  end

  def filename;  @title =~ /Messe de l'Emmanuel/ ? "messe_emmanuel.pdf" : "#{@name}.pdf";  end

end
