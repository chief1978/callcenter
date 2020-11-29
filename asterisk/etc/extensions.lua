TRUNK = "gw"


-- helper поиск значения в массиве true or false
local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- helper проверка на nil
local function isempty(s)
  return s == nil or s == ''
end

-- hangup с оценкой разговора
function mfc_hangup(c,e)

	local fr1 = "/var/lib/asterisk/sounds/mfc/check_quality/1"
	local fr2 = "/var/lib/asterisk/sounds/mfc/check_quality/2"
	local fr3 = "/var/lib/asterisk/sounds/mfc/check_quality/3"
	local r_status = nil
	local val = 0
	local ar_val = {'1', '2', '3', '4', '5'}

	app.noop("по окончанию разговора просим оценку")
	repeat
		app.read("val", fr1, 1, nil, 1, 6)
		r_status = channel.READSTATUS:get()
		app.noop("состояние канала " .. r_status)
		if r_status == "HANGUP" then
		    break
		end
		if r_status ~= "OK" then
		    app.playback(fr2)
		else
		    val = channel["val"]:get()
		    app.noop("пользователь поставил оценку " .. val)
		    if has_value(ar_val, val) then
			break
		    else
			app.playback(fr2)
		    end
		    
		end
	until false;

	channel["CDR(val)"]:set(val)
	app.noop("оценка записана " .. val)
	app.playback(fr3)

        app.hangup()
end


-- рабочие часы
w_time = {
	{ ["day"] = 1 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "18:00:00",},
	{ ["day"] = 2 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "18:00:00",},
	{ ["day"] = 3 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "18:00:00",},
	{ ["day"] = 4 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "18:00:00",},
	{ ["day"] = 5 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "18:00:00",},
	{ ["day"] = 6 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "19:00:00",},
	{ ["day"] = 7 , ["w_time_start"] = "09:00:00",  ["w_time_end"] = "19:00:00",}
}

-- рабочие дни недели
w_days = { 1, 2, 3, 4, 5 }

-- выходные дни и что будем проигрывать
h_date = {
	{ ["month"] = 2, ["day"] = 23, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 3, ["day"] = 8, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 5, ["day"] = 11, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
--	{ ["month"] = 5, ["day"] = 6, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
--	{ ["month"] = 11, ["day"] = 4, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
--	{ ["month"] = 11, ["day"] = 5, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 1, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 2, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 3, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 4, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 5, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 6, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 7, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 8, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 1, ["day"] = 9, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" }
}

-- дни с измененным графиком и что будем проигрывать
c_date = {
	{ ["month"] = 2, ["day"] = 22, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 3, ["day"] = 7, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 4, ["day"] = 30, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
--	{ ["month"] = 6, ["day"] = 11, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 11, ["day"] = 3, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" },
	{ ["month"] = 12, ["day"] = 31, w_time = { 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }, ["sound"] = "/var/lib/asterisk/sounds/mfc/callcenter/no_work/1" }
}

-- функция проверки рабочего времени
function check_w_time()

	local t = os.date("*t")
	local w_day = t['wday']
	local time = t['hour']
	local month = t['month']
	local m_day = t['day']
	local cur_time = os.time()
	
	for k,v in pairs(h_date) do
		if month == v["month"] and m_day == v["day"] then
			app.noop("выходной день")
			return false, v["sound"]
		end
	end

	for k,v in pairs(c_date) do
		if month == v["month"] and m_day == v["day"] then
			w_time_h = v["w_time"]
			for l,w in pairs(w_time_h) do
				if time == w then
					app.noop("предпраздничный день еще работаем")
					return true, nil
				end
			end
			app.noop("предпразничный день уже отдыхаем")
			return false, v["sound"]
		end
	end

	for k,v in pairs(w_time) do
		if w_day == v["day"] then
			w_start = os.date("!*t", cur_time)
			w_start.hour,w_start.min,w_start.sec = string.match(v["w_time_start"],"(%d%d)%p(%d%d)%p(%d%d)")
			w_end = os.date("!*t", cur_time)
			w_end.hour,w_end.min,w_end.sec = string.match(v["w_time_end"],"(%d%d)%p(%d%d)%p(%d%d)")
			app.noop("текущее время "  .. os.date("%X", cur_time))
			app.noop("время начала работы " .. os.date("%X", os.time(w_start)))
			app.noop("время окончания " .. os.date("%X", os.time(w_end)))
			if (os.time(w_start) < cur_time) and (os.time(w_end) > cur_time) then
				app.noop("рабочий день .. рабочее время")
				return true, nil
			end
		end
	end
	
	app.noop("выходной или уже не рабочее время")
	return false, nil
end

-- helper mixmonitor записи разговора
function record()
	local tpath="/tmp/"
	local dpath="/var/spool/asterisk/monitor/"
	local bin="/usr/local/bin/lame"
	local params=""
	local filename = channel.CHANNEL("UNIQUEID"):get() .. ".mp3"
	local str1=string.sub(filename,1,3) .. "/" .. string.sub(filename,4,6) .. "/" .. string.sub(filename,7,10)
	local str2=string.sub(filename,1,3) .. "/" .. string.sub(filename,4,6) .. "/" .. string.sub(filename,7,10)
	os.execute("mkdir -p /var/spool/asterisk/monitor/" .. str2)
	filename = str1 .. "/" .. filename
	app.noop("filename:" .. filename)
	local dfile = dpath .. filename
	local tfile = tpath .. channel.CHANNEL("UNIQUEID"):get() .. ".wav"
	local cmd = bin .. " " .. params .. " " .. tfile .. " " .. dfile .. " && rm " .. tfile
	app.mixmonitor(tfile, "b", cmd)
	return filename
end

-- очередь
-- Регистрация в очереди
function queue_login(context, extension, queue_name)
	app.noop("Регистрация оператора")
        local name = channel.CALLERID("name"):get()
        app.noop("  name:" .. name)
        local channeltype = channel.CHANNEL("channeltype"):get()
        app.noop("  channeltype:" .. channeltype)
        local peername = channel.CHANNEL("peername"):get()
        app.noop("  peername:" .. peername)
        MemberInfo = channeltype .. "/" .. peername
        extension = string.sub(extension, 2)
        app.noop("оператор " .. MemberInfo .. " зарегистрирован в очереди " .. queue_name)
        app.Playback("agent-loginok")
        app.AddQueueMember(queue_name, MemberInfo)
        app.Hangup(5)
end

-- Разрегистрация в очереди
function queue_logout(context, extension, queue_name)
        name = channel.CALLERID("name"):get()
        channeltype = channel.CHANNEL("channeltype"):get()
        peername = channel.CHANNEL("peername"):get()
	MemberInfo = channeltype .. "/" .. peername
        app.Playback("agent-loggedoff")
        app.noop("Оператор " .. MemberInfo .. " logoff from " .. queue_name)
	app.RemoveQueueMember(queue_name)
        app.Hangup(5)
end

-- IVR
-- звуки
local w1 = "/var/lib/asterisk/sounds/mfc/w1"
local w2 = "/var/lib/asterisk/sounds/mfc/w2"
local w3 = "/var/lib/asterisk/sounds/mfc/w3"
local w4 = "/var/lib/asterisk/sounds/mfc/w4"
local w5 = "/var/lib/asterisk/sounds/mfc/w5"
local n1 = "/var/lib/asterisk/sounds/mfc/n1"
local n2 = "/var/lib/asterisk/sounds/mfc/n2"
local n3 = "/var/lib/asterisk/sounds/mfc/n3"
local n4 = "/var/lib/asterisk/sounds/mfc/n4"

-- IVR привествие
function ivr_hello(c, e)
        app.wait(2)
        app.ringing()
        app.progress()
	-- проверяем рабочее ли время
	app.noop("ivr приветствие")
	app.noop("проверяем рабочее ли время ...")
	work, msg = check_w_time()
        if work == false then
		if msg == nil then
			msg = n1
		end
		-- если нет
		app.noop("... нет")
--		app.playback(s3, "noanswer")
--		app.hangup()
	end
	-- если да
	app.noop("да")
	msg = d1
	app.playback(msg, "noanswer")
end

-- IVR выбор меню
function ivr_start(c, e)
	app.answer()
	-- проверяем рабочее ли время
	app.noop("ivr start")
	app.noop("проверяем рабочее ли время ...")
	work, msg = check_w_time()
	if work == false then
		if msg == nil then
			msg = n2 .. "&" .. n3 .. "&" .. n4
		end
		-- если нет запускаем информационное сообщение и IVR menu
		app.noop(" ... нет, запускаем не_рабочее ivr меню")
		msg = n2 .. "&" .. n3 .. "&" .. n4 .. "&" .. "silence/2"
		app.background(msg,"","","nw_level_1")
		app.hangup()
	end
	-- если да запускаем информационное сообщение и IVR menu
	msg = w2 .. "&" .. w3 .. "&" .. w4 .. "&" .. w5 .. "silence/2"
	app.noop(" ... да, запускаем рабочее ivr меню")
	app.background(msg,"","","w_level_1")
	app.hangup()
end

-- IVR обработка таймаута ввода
function ivr_timeout(c, e)
	-- проверяем рабочее ли время
	app.noop("таймаут выбора, проверяем рабочее ли время ...")
	work, no_work_1_alt = check_w_time()
        if work == false then
    		app.noop("... нет - стартуем IVR заного")
    		ivr_start()
    	else
    		app.noop("... да - отправляем абонента на очередь")
    		get_queue(c, e, "mfc")
	end
end

-- IVR queue
function get_queue(c, e, queue_name)
	app.noop("... ставим абонента в очередь, используем макро - record для записи")
	app.queue(queue_name,"ctT","","","750","","record")
	local q_status = channel.QUEUESTATUS:get()
	if q_status == "TIMEOUT" then
--		app.playback(all_b)
		app.hangup()
	else
		mfc_hangup(c,e)
	end
end

-- обработка статуса запроса
function get_status(c, e)

	channel.CDR("ivr_choose"):set(1)
	app.read("deal", "inputDealNumber", 6, nil, 1, 7)
	local deal = channel["deal"]:get()
	app.noop("введен номер дела " .. deal)

	local numbers = channel.CDR("ivr_chk_numbers"):get() .. deal .. ";"
	channel.CDR("ivr_chk_numbers"):set(numbers)

	local quantity_str = channel.CDR("ivr_chk_quantity"):get()
	if isempty(quantity_str) then
	    quantity_str = "0"
	end
	local quantity = tonumber(quantity_str) + 1
	channel.CDR("ivr_chk_quantity"):set(quantity)

	app.read("pin", "inputPin", 4, nil, 1, 7)
	local pin = channel["pin"]:get()
	app.noop("введен пин " .. pin)

	local caller = channel.CALLERID("num"):get()
	app.noop("номер абонента " .. caller)

--	local agi_url = "agi://fastagi-srv/getStateScript.agi?dealNumber=" .. deal .. "&pin=" .. pin .. "&callerid=" .. caller
	local agi_url = "agi://fastagi-srv/getStateScript.agi?dealNumber=" .. deal .. "&pin=" .. pin
	app.noop("Вызываем agi приложение")
	app.noop(agi_url)
	channel.CHANNEL("AGISIGHUP"):set("no")
	app.AGI(agi_url)

	local agi_status = channel.AGISTATUS:get()
	app.noop("получен agi статус " .. agi_status)
	app.noop("отправляем обратно в IVR")
	channel.CDR("ivr_status"):set(agi_status)
	local datetime = os.date("*t",os.time())
	local dt_str = tostring(datetime.year) .. "-" .. tostring(datetime.month) .. "-" .. tostring(datetime.day) .. " " .. tostring(datetime.hour) .. ":" .. tostring(datetime.min) .. ":" .. tostring(datetime.sec)
	channel.CDR("ivr_quit"):set(dt_str)

	ivr_start()
end

-- список дел
function deal_list(c, e)
	local agi_url = "agi://127.0.0.1/getDealsScript.agi"
	app.noop("Вызываем agi приложение")
	app.noop(agi_url)
	app.AGI(agi_url)
end

function get_callback(c, e)
	app.answer()
	app.playback(n_w_ty_and_callback)
	app.hangup()
end

function dial_over_trunk(c, e, t)
	app.Dial("SIP/" .. e .. "@" .. t, ",tTU(macro-record)")
end

extensions = {

	w_level_1 = {
		["0"] = function(c, e)
		    get_queue(c, e, "mfc")
		end;
		["1"] = function(c, e)
		    get_status(c, e)
		end;
		["#"] = function(c,e)
		    ivr_start(c,e)
		end;
		i = function(c,e)
		    ivr_start(c,e)
		end;
		t = function(c, e)
		    get_queue(c, e, "mfc")
		end;
		h = function()
		    app.hangup()
		end;
	};
	
	
	w_level_1 = {
		["1"] = function(c,e)
		    get_status(c,e)
		end;
		["#"] = function(c,e)
		    ivr_start(c,e)
		end;
		i = function(c,e)
		    ivr_start(c,e)
		end;
		t = function(c,e)
		    ivr_start(c,e)
		end;
		h = function(c,e)
		    app.hangup(c,e)
		end;
	};

	callback = {
		["1"] = function(c,e)
		    get_callback(c,e)
		end;
	};
	
	deal_list = {
		s = function(c,e)
		    deal_list(c,e)
		end;
	};

	["macro-record"] = {
		s = function(c,e)
		    recordname = record()
		    channel.CDR("recordingfile"):set(recordname)
		end;
	};

	operator = {
		["*999"] = function(c, e)
		    queue_login(c, e, "mfc")
		end;
		["*888"] = function(c, e)
		    queue_logout(c, e, "mfc")
		end;
		["_5XXX"] = function(c, e)
		    app.Dial("SIP/" .. e, ",tTU(macro-record)")
		    app.hangup()
		end;
		["_XXXX."] = function(c, e)
		    dial_over_trunk(c,e,"gw")
		    app.hangup()
		end;
	};

	public = {
		s = function()
		    app.hangup()
		end;
		["88162608806"] = function(c,e)
		    ivr_hello(c,e)
		    ivr_start(c,e)
		end;
		i = function(c,e)
		    ivr_start(c,e)
		end;
		t = function(c,e)
		    ivr_timeout(c,e)
		end;
		h = function()
		    app.hangup()
		end;
	};
	
}
