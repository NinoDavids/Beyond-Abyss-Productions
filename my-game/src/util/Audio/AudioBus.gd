class_name AudioBus
enum BusTypes {
	MASTER,
	MUSIC,
	EFFECTS
}

static func convert_bus_type(bus_type: BusTypes) -> String:
    match bus_type:
        BusTypes.MASTER:
            return &"Master"
        BusTypes.MUSIC:
            return &"Music"
        BusTypes.EFFECTS:
            return &"Effects"
        _:
            return &"Master"