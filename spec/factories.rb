Factory.define :task do |t|
  t.name "foo"
  t.extension_name "BinaryFileExtension"
end

Factory.define :client do |c|
  c.ip "192.168.0.13"
  c.port "8080"
  c.association :task
end

Factory.define :data_pack do |d|
  d.association :task
  d.input_data "test"
  d.workflow_state "waiting"
end
