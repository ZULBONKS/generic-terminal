#!/usr/bin/env julia
# Linux Terminal Emulator in Julia (GTK)

using Gtk
using Gtk.ShortNames

win = Window("generic-terminal", 800, 600)
win.border_width = 10
vbox = Box(:v)
push!(win, vbox)

output = TextView()
output.editable = false
output.monospace = true
output_buffer = output.buffer
output_scroll = ScrolledWindow()
push!(output_scroll, output)
set_gtk_property!(output_scroll, :expand, true)

# YEAH
input = Entry()
signal_connect(input, "activate") do widget
    cmd = get_gtk_property(input, :text, String)
    if !isempty(cmd)
        set_gtk_property!(input, :text, "")

        end_iter = output_buffer.end_iter
        output_buffer[end_iter] = "\n\$ $cmd\n"
        
        try
            result = read(`sh -c $cmd`, String)
            output_buffer[end_iter] = result
        catch e
            output_buffer[end_iter] = "Error: $e\n"
        end
        
        # Auto-scroll to end
        end_iter = output_buffer.end_iter
        mark = output_buffer.create_mark("end", end_iter, false)
        scroll_to(output, mark, 0.0, false, 0.0, 1.0)
    end
end

pack!(vbox, output_scroll, expand=true, fill=true)
pack!(vbox, input, expand=false, fill=true)

showall(win)
signal_connect(win, "destroy") do w
    Gtk.gtk_quit()
end

Gtk.gtk_main()
