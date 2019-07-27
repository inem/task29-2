require 'rexml/document'
require_relative './lib/victorina.rb'

puts "\nВикторина вер. 1.0\n"

# читаем файл xml с данными
#
file_name = File.dirname(__FILE__) + '/data/questions.xml'

# присваеваем переменной questions сслыку на массив с объектами класса Question
#
questions = Question.read_questions(file_name)

# переменная - счетчик правильных ответов
#
counter_right_ansver = 0

# проходимся по всем элементам массива questions для прстроения логики программы
#
questions.each do |question|
  # время начала ответа на вопрос
  #
  start_timer = Time.new

  puts "\nВремя отведенное на вопрос: #{question.time_count} секунд!!!\n\n"

  # задаем вопрос
  #
  question.ask_question

  # предлагаем выбрать ответ
  #
  question.print_ansvers

  # обработка выбора пользователя
  #
  question.user_choice

  # сравниваем ответ пользователя с правильным ответом и сообщаем ему результат
  #
  if question.answer_correct?
    # если ответ совподает с правильным, то увеличиваем счетчик правильных ответов на еденицу
    #
    counter_right_ansver += 1

    puts "\nВерно!\n"
  else
    puts "\nНеверно!\n"
  end

  # время выбора ответа
  #
  end_timer = Time.new

  # проверка отведенного времени на ответ
  #
  if (end_timer - start_timer) > question.time_count
   puts "\nПревышено время отведенное на ответ! Начните все заново!\n\n"
  exit
  end 
end

# выводим результат работы программы
# 
puts "\nУ Вас #{counter_right_ansver} правильных ответов из #{questions.size}\n\n"

