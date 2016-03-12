﻿note
	description: "Main window for this application"
	author: "Generated by the New Vision2 Application Wizard."
	date: "$Date: 2016/2/4 22:50:1 $"
	revision: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {ANY} -- public variables

	floors: INTEGER
	building: ARRAY[BUILDING_FLOOR]
	dest_buttons: ARRAY[EV_BUTTON]
	status_panel: EV_LABEL


feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
				-- Create main container.
			create main_container
				-- Create the menu bar.
			create standard_menu_bar
				-- Create file menu.
			create file_menu.make_with_text (Menu_file_item)
				-- Create help menu.
			create help_menu.make_with_text (Menu_help_item)

				-- Create a toolbar.
			create standard_toolbar

				-- Create a status bar and a status label.
			create standard_status_bar
			create standard_status_label.make_with_text ("Add your status text here...")

				-- create elevator stuff
			create elevator_interior_box
			create elevator_interior_scroll_area
			create building_scroll_area
			create building_box
			create dest_buttons.make_empty
			create building.make_empty
			create status_panel

		end

	initialize
			-- Build the interface for this window.
		do
			floors := 9
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

				-- Create and add the toolbar.
			build_standard_toolbar
			upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})
			upper_bar.extend (standard_toolbar)

				-- Create and add the status bar.
			build_standard_status_bar
			lower_bar.extend (standard_status_bar)

			build_building_panel
			build_elevator_interior

			build_main_container
			extend (main_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window.
			set_title (Window_title)

				-- Set the initial size of the window.
			set_size (Window_width, Window_height)
		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state?
			-- (as stated in `initialize')
		do
			 Result := true --(width = Window_width) and then
	--			(height = Window_height) and then
		--		(title.is_equal (Window_title))
		end


feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		do
				-- Add the "File" menu.
			build_file_menu
			standard_menu_bar.extend (file_menu)
				-- Add the "Help" menu.
			build_help_menu
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_initialized: not standard_menu_bar.is_empty
		end

	build_file_menu
			-- Create and populate `file_menu'.
		local
			menu_item: EV_MENU_ITEM
		do
			create menu_item.make_with_text (Menu_file_new_item)
				--| TODO: Add the action associated with "New" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_open_item)
				--| TODO: Add the action associated with "Open" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_save_item)
				--| TODO: Add the action associated with "Save" here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_saveas_item)
				--| TODO: Add the action associated with "Save As..." here.
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_close_item)
				--| TODO: Add the action associated with "Close" here.
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_initialized: not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		local
			menu_item: EV_MENU_ITEM
		do
			create menu_item.make_with_text (Menu_help_contents_item)
				--| TODO: Add the action associated with "Contents and Index" here.
			help_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_help_about_item)
			menu_item.select_actions.extend (agent on_about)
			help_menu.extend (menu_item)

		ensure
			help_menu_initialized: not help_menu.is_empty
		end

feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window.

	build_standard_toolbar
			-- Populate the standard toolbar.
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
				-- Initialize the toolbar.
			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("open.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("save.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			standard_toolbar.extend (toolbar_item)
		ensure
			toolbar_initialized: not standard_toolbar.is_empty
		end

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar
			-- Populate the standard toolbar.
		do
				-- Initialize the status bar.
			standard_status_bar.set_border_width (2)

				-- Populate the status bar.
			standard_status_label.align_text_left
			standard_status_bar.extend (standard_status_label)
		end

feature {NONE} -- About Dialog Implementation

	on_about
			-- Display the About dialog.
		local
			about_dialog: ABOUT_DIALOG
		do
			create about_dialog
			about_dialog.show_modal_to_window (Current)
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- Process user request to close the window.
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button ~ (create {EV_DIALOG_CONSTANTS}).ev_ok then
					-- Destroy the window.
				destroy

					-- End the application.
					--| TODO: Remove next instruction if you don't want the application
					--|       to end when the first window is closed..
				if attached (create {EV_ENVIRONMENT}).application as a then
					a.destroy
				end
			end
		end

feature {NONE} -- Building Panel Implementation

	building_box: EV_VERTICAL_BOX

	build_building_panel
	local
		i: INTEGER;
		floor: BUILDING_FLOOR
	do

		from
			i := 0
		until
			i = floors
		loop
			create floor.default_create
			floor.set_floor(i + 1)
			floor.up.select_actions.extend (agent click_up_button(i))
			floor.down.select_actions.extend (agent click_down_button(i))
			building.force (floor, i)
			i := i + 1
		end
		from
			i := building.upper
		until
			i < building.lower
		loop
			building_box.extend (building[i])
			i := i - 1
		end
	end

feature {NONE} -- Elevator Interior Implementation

	elevator_interior_box: EV_VERTICAL_BOX

	build_elevator_interior
	local
		i, j: INTEGER
		button: EV_BUTTON
		button_row: EV_HORIZONTAL_BOX
		dest_buttons_box: EV_VERTICAL_BOX
	do
		from
			i := 0
		until
			i = floors
		loop
			create button.make_with_text_and_action ((i+1).out, agent click_dest_button(i))
			button.set_minimum_size (50, 50)
			dest_buttons.force (button, i)
			i := i + 1
		end
		create dest_buttons_box
		dest_buttons_box.set_padding_width (10)
		from
			i := dest_buttons.lower
		until
			i > dest_buttons.upper
		loop
			create button_row
			button_row.set_padding_width (10)
			from
				j := 0
			until
				j = 3 OR i > dest_buttons.upper
			loop
				button_row.extend (dest_buttons[i])
				j := j + 1
				i := i + 1
			end
			dest_buttons_box.put_front (button_row)
		end
		status_panel.set_text ("R 0")
		status_panel.set_foreground_color(create {EV_COLOR}.make_with_8_bit_rgb (0, 255, 0))
		status_panel.set_background_color(create {EV_COLOR}.make_with_8_bit_rgb (0,0,0))
		status_panel.set_font (create {EV_FONT}.make_with_values ({EV_FONT_CONSTANTS}.family_typewriter,
																  {EV_FONT_CONSTANTS}.weight_bold,
																  {EV_FONT_CONSTANTS}.shape_regular,
																  36))
		elevator_interior_box.extend (status_panel)
		elevator_interior_box.extend (dest_buttons_box)

	end

	click_up_button(floor: INTEGER)
	require
		valid_floor: building.upper >= floor AND building.lower <= floor
	do
		-- elevator_model.up_request(floor)
		status_panel.set_text ("up " + (floor+1).out)
	end

	click_down_button(floor: INTEGER)
	require
		valid_floor: building.upper >= floor AND building.lower <= floor
	do
		-- elevator_model.down_request(floor)
		status_panel.set_text ("down " + (floor+1).out)
	end

	click_dest_button(floor: INTEGER)
	require
		valid_floor: building.upper >= floor AND building.lower <= floor
	do
		--elevator_model.dest_request(floor)
		status_panel.set_text ("dest " + (floor+1).out)
	end

feature {NONE} -- Implementation

	main_container: EV_HORIZONTAL_BOX
			-- Main container (contains all widgets displayed in this window).
	building_scroll_area: EV_SCROLLABLE_AREA
	elevator_interior_scroll_area: EV_SCROLLABLE_AREA
			-- Scrollable areas containing elevator and buttons
			-- Actual content holders for building and elevator panel

	build_main_container
			-- Populate `main_container'.
		do
			building_scroll_area.set_minimum_size (200, 600)
			building_scroll_area.extend (building_box)
			elevator_interior_scroll_area.set_minimum_size (200, 600)
			elevator_interior_scroll_area.extend (elevator_interior_box)
			main_container.extend (building_scroll_area)
			main_container.extend (elevator_interior_scroll_area)
		ensure
			main_container_created: main_container /= Void
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "my_vision2_application_1"
			-- Title of the window.

	Window_width: INTEGER = 500
			-- Initial width for this window.

	Window_height: INTEGER = 700
			-- Initial height for this window.

end
