task :upload_form, [:file] => :environment do |_t, args|
  file_path = args[:file]
  workbook = Roo::Excelx.new(file_path) rescue nil
  abort "File '#{file_path}' '#{args.inspect}' could not be opened" if workbook.nil?

  sheet = workbook.sheet(0)
  name_row = sheet.row(1)
  form_name = name_row[0]
  if Form.find_by_name(form_name)
    abort "ERROR: Form '#{form_name}' already exists"
  end
  form = Form.new(name: form_name)
  if form.save
    puts "Form '#{form_name}' was created successfully, adding questions"
  else
    abort "ERROR: Form '#{form_name}' could not be created. #{form.errors.full_messages.join(';')}"
  end

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    question = form.questions.new(content: row[0], question_type: row[1].to_i, options: row[2..-1])
    if question.save
      puts "\tQuestion '#{question.content}' was added successfully"
    else
      puts "\tERROR: question '#{question.content}' could not be created. #{question.errors.full_messages.join(';')}"
    end
  end
end