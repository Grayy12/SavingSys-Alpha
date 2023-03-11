-- ALPHA MADE BY: Grayy#6068 https://discord.com/users/339838833489346560

local SaveSys = {}

local function CheckFile(filepath)
	if isfile(filepath) then
		return true
	else
		return false
	end
end

local function Hash(str: string)
	if syn.crypt.hash then
		return syn.crypt.hash(str)
	elseif sha384_hash then
		return sha384_hash(str)
	elseif fluxus.crypt.hash then
		return fluxus.crypt.hash(str)
	else
		return str
	end
end

function SaveSys.Init(Folder: string?, File: string)
	local self = {}
	if not isfolder or not isfile then
		warn("File Saving is not supported on this executor")
		return
	end

	if not Folder and not File then
		warn("Plase provide a folder and file name")
		return
	end
	if Folder ~= "" then
		self._FilePath = ("%s/%s"):format(Folder, File)
	else
		self._FilePath = File
	end

	self._Folder = Folder or ""

	if not isfolder(Folder) then
		makefolder(Folder)
	end

	if not isfile(self._FilePath) then
		writefile(self._FilePath, "")
	end

	function self:Save(Data: table, override: boolean?, encrypt: boolean?)
		override = override or false
		-- TODO: Add encryption
		if not CheckFile(self._FilePath) then
			warn("File does not exist")
			return
		end

		if not override then
			local OldData = self:Load()

			for i, v in next, OldData do
				Data[i] = v
			end
		end
		local Data = game:GetService("HttpService"):JSONEncode(Data)
		writefile(self._FilePath, Data)
	end

	function self:Load(encrypted: boolean?): table
		-- TODO: Add encryption
		if not CheckFile(self._FilePath) then
			warn("File does not exist")
			return
		end

		local Data = readfile(self._FilePath)

		if Data == "" then
			return {}
		end

		return game:GetService("HttpService"):JSONDecode(Data)
	end

	function self:SetupKey(key: string)
		local self2 = {}
		self2._Folder = self._Folder

		if not syn.crypt.hash and not sha384_hash and not fluxus.crypt.hash then
			warn("Encryption is not supported on this executor or not known, key will be visible")
		end
		if not CheckFile(("%s/%s"):format(self._Folder, "Key.txt")) and not CheckFile("Key.txt") then
			writefile(self._Folder ~= "" and ("%s/%s"):format(self._Folder, "Key.txt") or "Key.txt", Hash(key))
		end

		function self2:CheckKey(key: string): boolean
			if not CheckFile(("%s/%s"):format(self._Folder, "Key.txt")) and not CheckFile("Key.txt") then
				warn("Key file does not exist")
				return false
			end

			local Key = readfile(self._Folder ~= "" and ("%s/%s"):format(self._Folder, "Key.txt") or "Key.txt")

			if Hash(key) == Key then
				return true
			else
				return false
			end
		end

		return self2
	end

	return self
end

return SaveSys
