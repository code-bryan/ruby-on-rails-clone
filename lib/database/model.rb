module Database
  Model = Class.new(Sequel::Model)
  Model.def_Model(self)
  Model.db = DB
  Model.plugin :prepared_statements
end