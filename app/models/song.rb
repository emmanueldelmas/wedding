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
    Song.new(1, "psaumme_118", "Psaume 118", "Louange d'entrée", ""),
    Song.new(2, "kyrie", "Messe de l'Emmanuel - Kyrie", "Kyrie", "Communauté de l'Emmanuel"),
    Song.new(3, "gloria", "Messe de l'Emmanuel - Gloria", "Gloria", "Communauté de l'Emmanuel"),
    Song.new(4, "psaume", "Le Seigneur est ma Lumière et mon Salut", "Psaume", ""),
    Song.new(5, "alleluia", "Messe de l'Emmanuel - Alleluia", "Alleluia", "Communauté de l'Emmanuel"),
    Song.new(6, "litanie", "Litanie des saints Congolaise", "Litanie des saints", "Communauté du Chemin Neuf"),
    Song.new(7, "veni_sancte_spiritus", "Veni Sancte Spiritus", "Invocation à l'Esprit", "Anuncio https://www.youtube.com/watch?v=IPr80wHukYc"),
    Song.new(8, "acclamez_dieu_toute_la_terre", "Acclamez Dieu toute la Terre", "Action de grâce", ""),
    Song.new(9, "chant_promesse", "Chant de la promesse", "Promesse scout", "Père Jacques Sevin"),
    Song.new(10, "mendiez", "Mendiez l'humilité", "Prière universelle", "Frère Jean-Baptiste"),
    Song.new(11, "ne_crains_pas", "Ne crains pas, Je suis ton Dieu", "Offertoire", "Frère Jean-Baptiste"),
    Song.new(12, "sanctus", "Messe de l'Emmanuel - Sanctus", "Sanctus", "Communauté de l'Emmanuel"),
    Song.new(13, "anamnese", "Messe de l'Emmanuel - Anamnèse", "Anamnèse", "Communauté de l'Emmanuel"),
    Song.new(14, "agnus", "Messe de l'Emmanuel - Agnus", "Agnus", "Communauté de l'Emmanuel"),
    Song.new(15, "tu_fais_ta_demeure_en_nous", "Tu fais ta demeure en nous", "Communion", ""),
    Song.new(16, "jubilez", "Jubilez", "Louange finale", "Frère Jean-Baptiste"),
  ].freeze

  def self.all;  	SONGS.compact;  end
  def self.find(id);  	SONGS[id];  end

  def self.welcome_song;    find(9);  end

  def filename;  @title =~ /Messe de l'Emmanuel/ ? "messe_emmanuel.pdf" : "#{@name}.pdf";  end

end
