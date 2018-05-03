# If you need any help, contact Garry Chahal (gschahal@uci.edu)

# ----------------------------------------------------------------------------------------------------------------
MAX_USERS =  10000 # Max 88000
MAX_CHARACTERS = 140 # Max 145?
MAX_READ_PER_USER = 3 # No Max O(nk) n = num(Users), k = MAX_READ_PER_USER
# This will generate 5 surveys per user in the database even if users in database > MAX_USERS

# Clear Database (just in case it is needed)
def cleanDB()
    puts "Cleaning Database"
    User.destroy_all
    Character.destroy_all
    Survey.destroy_all
end

# If your database is huge this may take a while
#cleanDB() # Uncomment this line if you want to destroy the database and start from scratch
# ----------------------------------------------------------------------------------------------------------------

# User genders
USER_GENDER = ["Very Masculine", "Masculine", "Neutral", "Feminine", "Very Feminine", "Prefer not to state"]

# User races
USER_RACE = ["Asian", "Black", "Latinx", "Middle-Eastern", "Mixed", "White", "Prefer not to state"]

# Character apparent genders
CHARACTER_APPARENT_GENDER = ["Very Masculine", "Masculine", "Neutral", "Feminine", "Very Feminine", "Prefer not to state"]

# Character apparent races
CHARACTER_APPARENT_RACE = ["Asian", "Black", "Green", "Latinx", "Middle-Eastern", "Mixed", "White", "I don't know"]

# Character apparent species
CHARACTER_APPARENT_SPECIES = ["Cyborg", "Elf", "Goblin", "Human", "Half-Genie", "Vampire", "I don't know"]

def randomUserGender()
    return USER_GENDER[rand(USER_GENDER.length)]
end

def randomUserRace()
    return USER_RACE[rand(USER_RACE.length)]
end

def randomCharacterGender()
    return CHARACTER_APPARENT_GENDER[rand(CHARACTER_APPARENT_GENDER.length)]
end

def randomCharacterRace()
    return CHARACTER_APPARENT_RACE[rand(CHARACTER_APPARENT_RACE.length)]
end

def randomCharacterSpecies()
    return CHARACTER_APPARENT_SPECIES[rand(CHARACTER_APPARENT_SPECIES.length)]
end

def generateEmail(name)
	return name + "@" + name + ".com"
end

def getUserType()
    return 1
end

def getUserPicture(name)
    return name + "Picture"
end

def getUserPasswordDigest(name)
    return name + "Password"
end

def getCharacterPicture(name)
    return name + "PictureLink"
end

def getCharacterDesc(name)
    return name + "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed felis metus, scelerisque eu tincidunt in, fermentum id velit. Fusce vel dui dui. Mauris vehicula nulla leo, vel sodales neque elementum nec. Maecenas euismod sit amet lacus id consectetur. Duis eget ante vulputate, consectetur leo et, feugiat elit. Aliquam eu velit purus. Donec auctor ex vel lacus semper, at rutrum nisl ultricies. Vivamus sodales maximus elit eget porta. Maecenas tortor tellus, blandit eu faucibus id, tincidunt nec libero. Lorem ipsum dolor sit amet, consectetur adipiscing elit."
end

def getCharacterBio(name)
    return name + "Bio"
end

# Get a list of all active character IDs
def getCharacterIDList()
	characterIDs = []
	Character.all.each do |c|
		characterIDs << c.id
	end
	return characterIDs
end

# If character name is not given return something else
def padCharacterName(name)
	if name == ""
		return "Name Not Available Yet"
	end
	return name
end

# Survey names from file
def getUsernames(file)
    names = []
    File.open(file, "r") do |f|
    	f.each_line do |line|
    		names << line.chomp
    	end
    end
    return names
end

# Survey characters from file
def getCharacters(file)
	characters = []
	File.open(file, "r") do |f|
		f.each_line do |line|
			line = line.chomp.split(',')
			line[0] = padCharacterName(line[0])
			characters << line
		end
	end
	return characters
end

# Generate Users based on a list of names
def generateUserSeedData(names)
	users = []
	(User.all.length..names.length).each do |i|
		break if i >= MAX_USERS
    	users << {username: names[i], email: generateEmail(names[i]), race: randomUserRace(), gender: randomUserGender(), user_type: getUserType(), picture: getUserPicture(names[i]), password_digest: getUserPasswordDigest(names[i])}
	end
	User.create(users)
end

# Generate Characters based on a list of lists of character names and game_names
def generateCharacterSeedData(characters)
	characterDB = []
	(Character.all.length..characters.length).each do |i|
		break if i >= MAX_CHARACTERS
		characterDB << {character_name: characters[i][0], game_name: characters[i][1], character_desc: getCharacterDesc(characters[i][0]), picture_link: getCharacterPicture(characters[i][0]), character_bio_link: getCharacterBio(characters[i][0])}
	end
	Character.create(characterDB)
end


# Generate Surveys based on max surveys per user
def generateSurveySeedData()
	surveys = []
	characterIDList = getCharacterIDList()

	User.all.each do |user|
        counter = 0
		while not Survey.where(:user_id => user.id).length + counter >= MAX_READ_PER_USER
			surveys << {user_id: user.id, character_id: characterIDList[rand(characterIDList.length)], race: randomCharacterRace(), gender: randomCharacterGender(), species: randomCharacterSpecies()}
            counter += 1
		end
		if surveys.length >= MAX_READ_PER_USER*MAX_USERS
			break
		end
	end
    Survey.create(surveys)
end

# Seed User
def seedUser()
	puts "Generating User Tables"
	user_names = getUsernames("nameDB.csv")
	generateUserSeedData(user_names)
end

# Seed Character
def seedCharacter()
	puts "Generating Character Tables"
	characters = getCharacters("characterDB.csv")
	generateCharacterSeedData(characters)
end

# Seed Survey
def seedSurvey()
	puts "Generating Survey Tables"
	generateSurveySeedData()
end

# If your MAXes are huge this may take a while
seedUser()
seedCharacter()
seedSurvey()