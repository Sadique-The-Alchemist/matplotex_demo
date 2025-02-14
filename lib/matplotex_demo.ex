defmodule MatplotexDemo do
    @moduledoc false
      def copy(term) do
        text =
          if is_binary(term) do
            term
          else
            inspect(term, limit: :infinity, pretty: true)
          end

        port =
          if :os.type() == {:unix, :linux},
            do: Port.open({:spawn, "xclip -selection clipboard"}, [:binary]),
            else: Port.open({:spawn, "pbcopy"}, [])

        true = Port.command(port, text)
        true = Port.close(port)

        :ok
      end

      def line_plot(opts) do
        x = [1, 2, 3, 4, 6, 6, 7]
        y = [1, 3, 4, 4, 5, 6, 7]
        colors = [1, 3, 4, 4, 5, 6, 7]

        frame_width = 6
        frame_height = 6
        size = {frame_width, frame_height}
        margin = 0.05
        font_size = "16pt"
        title_font_size = "18pt"
        ticks = [1, 2, 3, 4, 5, 6, 7]
        opts = [colors: colors] ++ opts
        x
        |> Matplotex.plot(y, opts)
        |> Matplotex.figure(%{figsize: size, margin: margin})
        |> Matplotex.set_title("The Plot Title")
        |> Matplotex.set_xlabel("X Axis")
        |> Matplotex.set_ylabel("Y Axis")
        |> Matplotex.set_xticks(ticks)
        |> Matplotex.set_yticks(ticks)
        |> Matplotex.set_xlim({4, 7})
        |> Matplotex.set_ylim({4, 7})
        # TODO: Setting limits are not taking the proper xy values
        |> Matplotex.set_rc_params(
          x_tick_font_size: font_size,
          y_tick_font_size: font_size,
          title_font_size: title_font_size,
          x_label_font_size: font_size,
          y_label_font_size: font_size,
          title_font_size: title_font_size,
          legend_width: 0.1
        )
        |> Matplotex.show()
        |> copy()
      end

      def line_plot_by_options() do
        x = [1, 2, 3, 4, 6, 6, 7]
        y = [1, 3, 4, 4, 5, 6, 7]

        frame_width = 6
        frame_height = 6
        size = {frame_width, frame_height}
        margin = 0.05
        font_size = "16pt"
        title_font_size = "18pt"
        ticks = [0, 1, 2, 3, 4, 5, 6, 7]

        x
        |> Matplotex.plot(y,
          figsize: size,
          margin: margin,
          title: "The plot title",
          x_label: "X Axis",
          y_label: "Y Axis",
          x_tick: ticks,
          y_tick: ticks,
          x_limit: {0, 7},
          y_limit: {0, 7},
          x_tick_font_size: font_size,
          y_tick_font_size: font_size,
          title_font_size: title_font_size,
          x_label_font_size: font_size,
          y_label_font_size: font_size,
          y_tick_font_text_anchor: "start"
        )
        |> Matplotex.show()
        |> copy()
      end

      def line_plotc() do
        x = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        y = [1, 3, 4, 4, 5, 6, 7]

        frame_width = 8
        frame_height = 6
        size = {frame_width, frame_height}
        margin = 0.05
        font_size = "16pt"
        title_font_size = "18pt"
        ticks = [1, 2, 3, 4, 5, 6, 7]
        xticks = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

        x
        |> Matplotex.plot(y)
        |> Matplotex.figure(%{figsize: size, margin: margin})
        |> Matplotex.set_title("Sample plot")
        |> Matplotex.set_xlabel("X Axis")
        |> Matplotex.set_ylabel("Y Axis")
        |> Matplotex.set_xticks(xticks)
        |> Matplotex.set_yticks(ticks)
        |> Matplotex.set_xlim({1, 7})
        |> Matplotex.set_ylim({1, 7})
        |> Matplotex.set_rc_params(
          x_tick_font_size: font_size,
          y_tick_font_size: font_size,
          title_font_size: title_font_size,
          x_label_font_size: font_size,
          y_label_font_size: font_size,
          title_font_size: title_font_size
        )
        |> Matplotex.show()
        |> copy()
      end

      # def bar() do
      #   values = [2, 1, 3, 7, 3, 5, 4]
      #   categories = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

      #   frame_width = 8
      #   frame_height = 6
      #   size = {frame_width, frame_height}
      #   margin = 0.05
      #   font_size = 0
      #   title_font_size = 0
      #   yticks = [0, 1, 2, 3, 4, 5, 6, 7]

      #   categories
      #   |> Matplotex.bar(values)
      #   |> Matplotex.figure(%{figsize: size, margin: margin})
      #   |> Matplotex.set_title("Sample barchart")
      #   |> Matplotex.set_xticks(categories)
      #   |> Matplotex.set_yticks(yticks)
      #   |> Matplotex.set_xlabel("Category")
      #   |> Matplotex.set_ylabel("Values")
      #   |> Matplotex.set_xlim({1, 7})
      #   |> Matplotex.set_ylim({0, 7})
      #   |> Matplotex.hide_v_grid()
      #   |> Matplotex.set_rc_params(
      #     x_tick_font_size: font_size,
      #     y_tick_font_size: font_size,
      #     title_font_size: title_font_size,
      #     x_label_font_size: font_size,
      #     y_label_font_size: font_size,
      #     title_font_size: title_font_size,
      #     y_padding: 0
      #   )
      #   |> Matplotex.show()
      #   |> copy()
      # end

      def scatter() do
        # x = [10, 20, 3, 4, 6, 6, 7]
        # y = [1, 3, 4, 4, 5, 6, 7]
        x = [0, 10, 20]
        y = [0, 10, 20]
        frame_width = 10
        frame_height = 10
        size = {frame_width, frame_height}
        margin = 0.05
        font_size = "16pt"
        title_font_size = "18pt"
        ticks = [0, 10, 20]

        x
        |> Matplotex.scatter(y)
        |> Matplotex.figure(%{figsize: size, margin: margin})
        |> Matplotex.set_title("Sample Scatter plot")
        |> Matplotex.set_xlabel("X Axis")
        |> Matplotex.set_ylabel("Y Axis")
        |> Matplotex.set_xticks(ticks)
        |> Matplotex.set_yticks(ticks)
        |> Matplotex.set_xlim({0, 20})
        |> Matplotex.set_ylim({0, 20})
        # TODO: Setting limits are not taking the proper xy values
        |> Matplotex.set_rc_params(
          x_tick_font_size: font_size,
          y_tick_font_size: font_size,
          title_font_size: title_font_size,
          x_label_font_size: font_size,
          y_label_font_size: font_size,
          title_font_size: title_font_size
        )
        |> Matplotex.show()
        |> copy()
      end

      def multiline_plot() do
        x = [1, 2, 3, 4, 5]
        # Dataset 1
        y1 = [1, 4, 9, 16, 25]
        # Dataset 2
        y2 = [1, 3, 6, 10, 15]
        # Dataset 3
        y3 = [2, 5, 7, 12, 17]

        x
        |> Matplotex.plot(y1, color: "blue", linestyle: "_", marker: "o", label: "Dataset 1")
        |> Matplotex.plot(x, y2, color: "red", linestyle: "--", marker: "^", label: "Dataset 2")
        |> Matplotex.plot(x, y3, color: "green", linestyle: "-.", marker: "s", label: "Dataset 3")
        |> Matplotex.set_title("Title")
        |> Matplotex.set_xticks([1, 2, 3, 4, 5])
        |> Matplotex.set_xlabel("X-Axis")
        |> Matplotex.set_ylabel("Y-Axis")
        |> Matplotex.show()
        |> copy()
      end

      def minscatter() do
        IO.inspect(System.monotonic_time(:nanosecond), label: "Starting")
        beginning = System.monotonic_time()
        x= Nx.Random.key(12) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()
        y1 = Nx.Random.key(13) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()
        y2 = Nx.Random.key(14) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()
        plot = x
        |>Matplotex.scatter(y1, color: "#EE3377", x_label: "", y_label: "", label: "Amet")
        |>Matplotex.scatter(x,y2, color: "#0077BB", x_label: "", y_label: "", label: "Donor", show_legend: false, concurrency: 12)
        |>Matplotex.show()
        IO.inspect(abs(System.monotonic_time(:nanosecond)) - abs(beginning) , label: "Time taken")
        copy(plot)
      end

      def step() do
        x = [1, 2, 3, 4, 5]
        y1 = [1, 4, 9, 16, 25]
        y2 = [1, 3, 6, 10, 15]
        x
        |>Matplotex.step(y1, color: "#EE3377",label: "Amet")
        |>Matplotex.step(x,y2, color: "#0077BB", x_label: "", y_label: "", label: "Donor", show_legend: false)
        |> Matplotex.set_xticks([1, 2, 3, 4, 5])
        |>Matplotex.show()
        |>copy()

      end

      def bar() do
        categories = ["1","2", "3","4"]
        values = [22, 33, 28, 34]

        width = 0.8
        Matplotex.bar(values,width, color: "#7C6D91", x_label: "", y_label: "", show_legends: false)
        |> Matplotex.set_xticks(categories)
        |> Matplotex.set_ylim({0,40})
        |> Matplotex.hide_v_grid()
        |> Matplotex.show()
        |> copy()
      end

      def rrdpie() do
        # Percentages for each slice
        sizes = [25, 35, 20, 20, 10]
        # Labels for each slice
        labels = ["Lorem", "Ipsum", "Donor", "Bit", "Amet"]
        # Colors for the slices
        colors = ["#33BBEE", "#EE7733", "#EE3377", "#EE3377","#008080"]

        sizes
        |> Matplotex.pie(colors: colors, labels: labels)
        |> Matplotex.set_rc_params(%{line_width: 1, legend_width: 0.25})
        |> Matplotex.figure(%{figsize: {8.5, 5}})
        |> Matplotex.show()
        |>copy()
    end


      def multi_bar() do
        categories = ["apple", "banana", "fig", "avocado"]
        values1 = [22, 33, 28, 34]
        values2 = [53, 63, 59, 60]
        values3 = [50, 60, 50, 55]
        width = 0.22

        Matplotex.bar(-2 * width, values1, width, label: "Dataset1", color: "#255199")
        |> Matplotex.bar(-width, values2, width, label: "Dataset2", color: "orange")
        |> Matplotex.bar(0, values3, width, label: "Dataset3", color: "green")
        |> Matplotex.set_xticks(categories)
        |> Matplotex.figure(%{figsize: {10, 10}, margin: 0.05})
        |> Matplotex.set_title("Bar chart")
        |> Matplotex.set_xlabel("X-axis")
        |> Matplotex.set_ylabel("Y-Axis")
        |> Matplotex.hide_v_grid()
        |> Matplotex.set_ylim({0, 70})
        |> Matplotex.show()
        |> copy()
      end
      def stacked_bar() do
        categories = ["apple", "banana", "fig", "avocado"]
        values1 = [22, 33, 28, 34]
        values2 = [53, 63, 59, 60]
        values3 = [50, 60, 50, 55]
        width = 0.3

        Matplotex.bar(-0.5 * width, values1, width, label: "Dataset1", color: "#255199")
        |> Matplotex.bar(-0.5 * width, values2, width, label: "Dataset2", color: "orange", bottom: [values1])
        |> Matplotex.bar(-0.5 * width, values3, width, label: "Dataset3", color: "green", bottom: [values2, values1])
        |> Matplotex.set_xticks(categories)
        |> Matplotex.show()
        |> copy()
      end

      def multiline_scatter() do
        x = [1, 2, 3, 4, 5]
        # Dataset 1
        y1 = [20, 5, 12, 16, 25]
        # Dataset 2
        y2 = [10, 1, 6, 10, 15]
        # Dataset 3
        y3 = [17, 5, 8, 12, 17]

        x
        |> Matplotex.scatter(y1, color: "blue", linestyle: "_", marker: "o", label: "Dataset 1")
        |> Matplotex.scatter(x, y2, color: "red", linestyle: "--", marker: "^", label: "Dataset 2")
        |> Matplotex.scatter(x, y3, color: "green", linestyle: "-.", marker: "s", label: "Dataset 3")
        |> Matplotex.figure(%{figsize: {8, 8}, margin: 0.05})
        |> Matplotex.set_title("Title")
        |> Matplotex.set_xlabel("X-Axis")
        |> Matplotex.set_ylabel("Y-Axis")
        |> Matplotex.show()
        |> copy()
      end

      def pie() do
        # Percentages for each slice
        sizes = [25, 35, 20, 20, 10]
        # Labels for each slice
        labels = ["A", "B", "C", "D", "E"]
        # Colors for the slices
        colors = ["#33BBEE", "#EE7733", "#EE3377", "#0077BB","#919D41"]

        sizes
        |> Matplotex.pie(colors: colors, labels: labels)
        |> Matplotex.set_title("Pie chart")
        |> Matplotex.figure(%{figsize: {4, 3}, margin: 0.05})
        |> Matplotex.set_rc_params(%{line_width: 1, legend_width: 0.25})
        |> Matplotex.show()
        |> copy()
      end

      def photon_scatter() do
        {density, energy} =
          "samples/photon.csv"
          |> Path.expand()
          |> File.stream!()
          |> CSV.decode!()
          |> Stream.drop(1)
          |> Stream.map(fn [density, energy, _continent, _emission, _, _] ->
            {String.to_float(density), String.to_float(energy)}
          end)
          |> Enum.unzip()

        Matplotex.scatter(density, energy, color: "#FBD1A2", marker: "o", label: "Photo energy")
        |> Matplotex.figure(%{figsize: {10, 4}, margin: 0.05})
        |> Matplotex.set_title("Photon density and photon energy")
        |> Matplotex.set_xlabel("Photon density")
        |> Matplotex.set_ylabel("Photon energy")
        |> Matplotex.show()
        |> copy()
      end

      def emission_pie() do
        categories = ["2008", "2009", "2010", "2011"]
        values = [18.48923375, 17.1923791, 17.48479218, 17.02021634]

        colors = ["#76b5c5", "#DEDEDE", "#FBD1A2", "#6195B4"]

        values
        |> Matplotex.pie(colors: colors, labels: categories)
        |> Matplotex.set_title("Asias Emission distribution(2008-2011)")
        |> Matplotex.set_rc_params(%{line_width: 1, legend_width: 0.5})
        |> Matplotex.figure(%{figsize: {10, 4}, margin: 0.15})
        |> Matplotex.show()
        |> copy()
      end

      def rdpie() do
          # Percentages for each slice
          sizes = [25, 35, 20, 20, 10]
          # Labels for each slice
          labels = ["Lorem", "Ipsum", "Donor", "Bit", "Amet"]
          # Colors for the slices
          colors = ["#33BBEE", "#EE7733", "#EE3377", "#EE3377","#008080"]

          sizes
          |> Matplotex.pie(colors: colors, labels: labels)
          |> Matplotex.set_rc_params(%{line_width: 1, legend_width: 0.25})
          |> Matplotex.show()
          |>copy()
      end

      def hist() do
        values = Nx.Random.key(12) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()
        bins = 100

        Matplotex.hist(values, bins,
          x_label: "Value",
          y_label: "Frequency",
          title: "Histogram",
          color: "blue",
          edge_color: "black",
          alpha: 0.7,
          x_ticks_count: 9
        )
        |> Matplotex.show()
        |> copy()
      end

      def multi_hist() do
        values1 =
          Nx.Random.key(12) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()

        bins = 30
        values2 = Nx.Random.key(13) |> Nx.Random.normal(0, 1, shape: {500}) |> elem(0) |> Nx.to_list()

        Matplotex.hist(values1, bins,
          x_label: "Value",
          y_label: "Frequency",
          title: "Histogram",
          color: "blue",
          edge_color: "black",
          alpha: 0.7,
          x_ticks_count: 9
        )
        |> Matplotex.hist(values2, bins, color: "red")
        |> Matplotex.show()
        |> copy()
      end

      def spline() do
        x_nx = Nx.linspace(0, 10, n: 100)
        x = Nx.to_list(x_nx)
        y = x_nx |> Nx.sin() |> Nx.to_list()

        Matplotex.spline(x, y, edge_color: "cyan")
        |> Matplotex.show()
        |> copy()
      end
      def rdspline() do
        x = Nx.linspace(0, 10, n: 100)|> Nx.to_list()
        y1 = Nx.Random.key(12) |> Nx.Random.normal(0, 10, shape: {100}) |> elem(0) |> Nx.to_list()
        y2 = Nx.Random.key(13) |> Nx.Random.normal(0, 10, shape: {100}) |> elem(0) |> Nx.to_list()

        Matplotex.spline(x, y1,color: "#919D41", line_width: 3)
        |>Matplotex.spline(x,y2,color: "#008080", line_width: 3)
        |> Matplotex.set_ylim({-30, 30})
        |> Matplotex.show()
        |> copy()
      end
      def minhist() do
        values = Nx.Random.key(12) |> Nx.Random.normal(0, 1, shape: {1000}) |> elem(0) |> Nx.to_list()
        bins = 100
        Matplotex.hist(values, bins,
          x_label: "",
          y_label: "",
          color: "#EE7733",
          edge_color: "#EE7733"
        )
        |> Matplotex.set_ylim({0, 50})
        |> Matplotex.show()
        |> copy()
      end

      def line_n() do
        x = Nx.linspace(0, 10, n: 100)|> Nx.to_list()
        y1 = Nx.Random.key(12) |> Nx.Random.normal(0, 10, shape: {100}) |> elem(0) |> Nx.to_list()
        y2 = Nx.Random.key(13) |> Nx.Random.normal(0, 10, shape: {100}) |> elem(0) |> Nx.to_list()

        x
        |> Matplotex.plot(y1, color: "#EE3377",label: "Tarus")
        |> Matplotex.plot(x,y2, color: "#0077BB",label: "Ipsum", show_legend: false)
        |> Matplotex.show()
        |> copy()
      end


      def multi_spline() do
        x_nx = Nx.linspace(0, 10, n: 100)
        x = Nx.to_list(x_nx)
        y1 = x_nx |> Nx.sin() |> Nx.to_list()
        y2 = x_nx |> Nx.cos() |> Nx.to_list()

        Matplotex.spline(x, y1, x_label: "X", y_label: "Y", edge_color: "green")
        |> Matplotex.spline(x, y2, x_label: "X", y_label: "Y", edge_color: "red")
        |> Matplotex.show()
        |> copy()
      end

      def mrd_bar() do
        categories = ["Lorem", "Ipsum", "Amet", "Donor"]
        values1 = [22, 33, 28, 34]
        values2 = [53, 63, 59, 60]
        width = 0.35

        Matplotex.bar(width, values1, width, label: "Eiusmod", color: "#EE3377", edge_color: "#EE3377")
        |> Matplotex.bar(-width, values2, width, label: "Tempor", color: "#0077BB", edge_color: "#0077BB",x_label: "", y_label: "", show_legend: false)
        |> Matplotex.set_xticks(categories)
        |> Matplotex.hide_v_grid()
        |> Matplotex.set_ylim({0, 70})
        |> Matplotex.show()
        |> copy()
      end

end
