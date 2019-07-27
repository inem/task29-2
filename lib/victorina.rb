require 'rexml/document'

class Question
  # статический метод класса для создания и инициализации экземпляров класса, который будет возвращать массив созданных экземпляров
  #
  def self.read_questions(file_name)
    # читаем файл xml
    #
    file = File.new(file_name, "r:utf-8")

    # создаем экземпляр класса Document
    #
    doc = REXML::Document.new(file)
    file.close

    # массив для создоваемых экземпларов
    #
    questions = []

    # для каждого экземпляра собираем данные из xml файла
    #
    doc.elements.each('questions/question') do |xml_elements|
      text = ''
      variants_ansvers = []
      right_ansver = 0
      time_to_answer = xml_elements.attributes['seconds'] 

      # выбираем текст вопроса и варианты ответов
      #
      xml_elements.elements.each do |element|
        if element.name == 'text'
          text = element.text
        elsif element.name == 'variants'
          element.elements.each_with_index do |variant, index|
            variants_ansvers << variant.text

            right_ansver = index if variant.attributes['right']
          end
        end
      end

      # добавляем созданный вопрос в массив
      #
      questions << Question.new(text, variants_ansvers, right_ansver, time_to_answer)
    end

    # возвращаем массив вопросов из метода
    #
    questions
  end

  def initialize(text, variants_ansvers, right_ansver, time_to_answer)
    @text = text
    @variants_ansvers = variants_ansvers
    @right_ansver = right_ansver
    @time_to_answer = time_to_answer
  end

  #задаем вопрос
  #
  def ask_question
    puts @text
  end

  # вывод возможных ответов
  #
  def print_ansvers
    @variants_ansvers.each.with_index(1) { |variant, index| puts "#{index}. #{variant}" }
  end

  # обработка выбора пользователя
  #
  def user_choice
    user_index = STDIN.gets.chomp.to_i - 1

    @correct = (@right_ansver == user_index)
  end

  # true - если ответ юзера верный
  def answer_correct?
    @correct
  end

  def time_count
    @time_to_answer.to_i
  end

end
