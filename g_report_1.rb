# Reference from 'https://nayan.co/blog/Ruby-on-Rails/generating-pdf-in-ruby-on-rails/'

class PrawnReports
  require 'fileutils'
  require 'prawn'
  require 'prawn/table'
  require 'prawn-graph'
  require 'pry'
  include Prawn::View

  def initialize
    p "------------Hello World !-------------"

    # create dorectory if not exist
    FileUtils.mkdir_p("/home/bhargav/Projects/Bhargav/Ruby/prawn/reports")
    @document = Prawn::Document.new(page_size: 'A4', margin: 40)

    start_documentation
    @document.render_file('reports/report_1.pdf')
  end

  def leave_blank_line(count = 1)
    text "\n" * count
  end

  def start_documentation
    series = []
    series << Prawn::Graph::Series.new([4,9,3,2,1,6,2,8,2,3,4,9,2], title: "A label for a series", type: :bar)
    series << Prawn::Graph::Series.new([5,4,3,2,7,9,2,8,7,5,4,9,2], title: "Another label", type: :line, mark_average: true, mark_minimum: true)
    series << Prawn::Graph::Series.new([1,2,3,4,5,9,6,4,5,6,3,2,11], title: "Yet another label", type: :bar)
    series << Prawn::Graph::Series.new([1,2,3,4,5,12,6,4,5,6,3,2,9].shuffle, title: "One final label", type: :line, mark_average: true, mark_maximum: true)

    xaxis_labels = ['0900', '1000', '1100', '1200', '1300', '1400', '1500', '1600', '1700', '1800', '1900', '2000', '2100']

    table_data = [['Items', 'Rates'],
                  ['Item1', "1"],
                  ['Item2', "2"],
                  ['', ''], # For adding gap between my data
                  ['Item3', "3"],
                  ['Item4', "4"]]
      
    draw_header

    table table_data, cell_style: {border_width: 0, width: 250, padding: [5, 0, 5, 0], text_color: '373737'} do
      # Aligning a specific column cells' text to right
      columns(-1).align = :center
      columns(-2).align = :center
    
      # To add bottom padding to a specific row
      row(-2).padding_bottom = 10
    
      # To set width of border for a specific row
      row(-1).border_top_width = 1
    end
    graph(series, width: 500, height: 200, title: "A Title for the chart", at: [25, 550], xaxis_labels: xaxis_labels)
    graph(series, width: 500, height: 200, title: "A Title for the chart", at: [25, 300], xaxis_labels: xaxis_labels)

    start_new_page

    graph(series, width: 500, height: 200, title: "A Title for the chart", at: [25, 720], xaxis_labels: xaxis_labels)
  end

  def draw_header
    # repeat used for add in every page.
    repeat(:all) do
      bounding_box([0, 780], width: 500, height: 20) do
        text("-----   Hello world !  -----", style: :bold, size: 20, color: '7f7f7f', align: :center)
      end
      leave_blank_line
    end
  end
end

PrawnReports.new