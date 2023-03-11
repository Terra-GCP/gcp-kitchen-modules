#.................................. Local Exec Block ...................................#

resource "null_resource" "local-exec" {
  provisioner "local-exec" {
    command     = var.command 
    working_dir = var.working_dir
    interpreter = var.interpreter
    when        = create
  }
}
