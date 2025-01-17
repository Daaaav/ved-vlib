return {
    AlignContainer(
        elListContainer:new{
            cw = 128, ch = nil,
            start = 8,
            spacing = 8,
            start_bot = 8,
            spacing_bot = 8,
            els_top = {
                Text("Options"),

                DrawingFunction(
                    function(x, y, maxw, maxh)
                        ved_printf("FPS Target", x, y, maxw, "center")
                        for k,v in pairs({
                            {false, "30 FPS"},
                            {true, "30+ FPS"}
                        }) do
                            radio_wrap(VLIB_SETTINGS.over30 == v[1], x, y+(24*k)-4, v[1], v[2], 96,
                                function(key)
                                    VLIB_Set("over30", v[1])
                                end
                            )
                        end
                        return 112, 20+24*2
                    end
                ),

                DrawingFunction(
                    function(x, y, maxw, maxh)
                        ved_printf("Game speed", x, y, maxw, "center")
                        for k,v in pairs({
                            {34, "100%"},
                            {41, "80%"},
                            {55, "60%"},
                            {83, "40%"}
                        }) do
                            radio_wrap(VLIB_SETTINGS.game_speed == v[1], x, y+(24*k)-4, v[1], v[2], 96,
                                function(key)
                                    VLIB_Set("game_speed", v[1])
                                end
                            )
                        end
                        return 112, 20+24*4
                    end
                ),

                DrawingFunction(
                    function(x, y, maxw, maxh)
                        checkbox(VLIB_SETTINGS.invincibility, x, y, nil, "Invincible", function()
                            VLIB_Set("invincibility", not VLIB_SETTINGS.invincibility)
                        end)
                        return 8 + 32 + font_ui:getWidth("Invincible"), 16
                    end
                ),

                DrawingFunction(
                    function (x, y, maxw, maxh)
                        local w, h = VLIB_Slider(x, y, "Music", 64, VLIB_SETTINGS.music_volume, 256, function(new)
                            VLIB_Set("music_volume", new)
                        end)
                        local w2, h2 = VLIB_Slider(x, y + h, "Sounds", 64, VLIB_SETTINGS.sfx_volume, 256, function(new)
                            VLIB_Set("sfx_volume", new)
                        end)
                        return math.max(w, w2), h + h2
                    end
                ),

                DrawingFunction(
                    function(x, y, maxw, maxh)
                        checkbox(VLIB_SETTINGS.show_ghosts, x, y, nil, "Show ghosts", function()
                            VLIB_Set("show_ghosts", not VLIB_SETTINGS.show_ghosts)
                        end)
                        return 8 + 32 + font_ui:getWidth("Show ghosts"), 16
                    end
                ),

                DrawingFunction(
                    function(x, y, maxw, maxh)
                        ved_printf("Translucent\nroom name", x, y, maxw, "center")
                        for k,v in pairs({
                            {nil, "Synced"},
                            {true, "Translucent"},
                            {false, "Opaque"},
                        }) do
                            radio_wrap(VLIB_SETTINGS.translucent_bg == v[1], x, y+(24*k)-4, v[1], v[2], 96,
                                function(key)
                                    VLIB_Set("translucent_bg", v[1])
                                end
                            )
                        end
                        return 112, 20+24*3
                    end
                ),

                --LabelButton("a"),
                --LabelButton("b"),
                --LabelButton("c"),
            },
            els_bot = {
                LabelButton("Flags", function()
                    VLIB_CHANNEL_IN:push({
                        type = "clear_input"
                    })
                    to_astate("vlib_flags")
                end),
            }
        },
        ALIGN.LEFT
    ),
    RightBar(
        {
        },
        {
            LabelButtonSpacer(),
            LabelButton(L.RETURN, function()
                VLIB_CHANNEL_IN:push({
                    type = "stop"
                })
            end, "sn", hotkey("return", "shift")),
        }
    ),
}
