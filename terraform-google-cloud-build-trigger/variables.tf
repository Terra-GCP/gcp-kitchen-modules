variable "name" {
  description = "Name of the trigger. Must be unique within the project."
  type        = string
  default     = ""
}
variable "description" {
  description = "Human-readable description of the trigger."
  type        = string
}
variable "tags" {
  description = "Tags for annotation of a BuildTrigger"
  type        = string
}
variable "disabled" {
  type        = bool
  description = "Whether the trigger is disabled or not. If true, the trigger will never result in a build."
}
variable "substitutions" {
  type        = string
  description = "Substitutions data for Build resource."
}
variable "service_account" {
  type        = string
  description = "The service account used for all user-controlled operations including triggers.patch, triggers.run, builds.create, and builds.cancel. If no service account is set, then the standard Cloud Build service account ([PROJECT_NUM]@system.gserviceaccount.com) will be used instead."
}
variable "include_build_logs" {
  type        = string
  description = "Build logs will be sent back to GitHub as part of the checkrun result. Values can be INCLUDE_BUILD_LOGS_UNSPECIFIED or INCLUDE_BUILD_LOGS_WITH_STATUS Possible values are: INCLUDE_BUILD_LOGS_UNSPECIFIED, INCLUDE_BUILD_LOGS_WITH_STATUS."
}
variable "filename" {
  type        = string
  description = "Path, from the source root, to a file whose contents is used for the template. Either a filename or build template must be provided. Set this only when using trigger_template or github. When using Pub/Sub, Webhook or Manual set the file name using git_file_source instead."
}
variable "filter" {
  type        = string
  description = "A Common Expression Language string. Used only with Pub/Sub and Webhook."
}

variable "git_file_source" {
  description = "The file source describing the local or remote Build template."
  type = list(object(
    {
        path                              = string
        uri                               = string
        repo_type                         = string
        revision                          = string
        github_enterprise_config          = string
    }
    )
    )

  default = [
    {
        path                              = ""
        uri                               = ""
        repo_type                         = ""
        revision                          = ""
        github_enterprise_config          = ""    
    }
    ]
}

variable "repository_event_config" {
  description = "The configuration of a trigger that creates a build whenever an event from Repo API is received."
  type = list(object(
    {
        repository                        = string
        pull_request                      = object(
            {
                branch                    = string
                invert_regex              = string
                comment_control           = string
            }
        )

        push                              = object(
            {
                branch                    = string
                tag                       = string
                invert_regex              = string
            }
        )
    }
    )
    )

  default = [
    {
        repository                        = ""
        pull_request                      = {
                branch                    = ""
                invert_regex              = ""
                comment_control           = ""
            }

        push                              = {
                branch                    = ""
                tag                       = ""
                invert_regex              = ""
            }
    }
    ]
}

variable "source_to_build" {
  description = "The repo and ref of the repository from which to build.This field is currently only used by Webhook, Pub/Sub, Manual, and Cron triggers. One of trigger_template, github, pubsub_config webhook_config or source_to_build must be provided."
  type = list(object(
    {
        uri                               = string
        ref                               = string
        repo_type                         = string
        github_enterprise_config          = string
    }
    )
    )

  default = [
    {
        uri                               = ""
        ref                               = ""
        repo_type                         = ""
        github_enterprise_config          = ""
    }
    ]
}

variable "ignored_files" {
  description = "ignoredFiles and includedFiles are file glob matches using https://golang.org/pkg/path/filepath/#Match extended with support for **"
  type        = string
}
variable "included_files" {
  description = "ignoredFiles and includedFiles are file glob matches using https://golang.org/pkg/path/filepath/#Match extended with support for **"
  type        = string
}

variable "trigger_template" {
  description = "The repo and ref of the repository from which to build.This field is currently only used by Webhook, Pub/Sub, Manual, and Cron triggers. One of trigger_template, github, pubsub_config webhook_config or source_to_build must be provided."
  type = list(object(
    {
        project_id                        = string
        repo_name                         = string 
        dir                               = string
        invert_regex                      = string
        branch_name                       = string
        tag_name                          = string
        commit_sha                        = string
    }
    )
    )

  default = [
    {
        project_id                        = ""
        repo_name                         = "" 
        dir                               = ""
        invert_regex                      = ""
        branch_name                       = ""
        tag_name                          = ""
        commit_sha                        = ""
    }
    ]
}

variable "github" {
  description = "Describes the configuration of a trigger that creates a build whenever a GitHub event is received. One of trigger_template, github, pubsub_config or webhook_config must be provided."
  type = list(object(
    {
        owner                             = string
        name                              = string
        pull_request                      = object(
            {
                branch                    = string
                invert_regex              = string
                comment_control           = string
            }
        )

        push                              = object(
            {
                branch                    = string
                tag                       = string
                invert_regex              = string
            }
        )

        enterprise_config_resource_name   = string
    }
    )
    )

  default = [
    {
        owner                             = ""
        name                              = ""
        pull_request                      = {
                branch                    = ""
                invert_regex              = ""
                comment_control           = ""
            }

        push                              = {
                branch                    = ""
                tag                       = ""
                invert_regex              = ""
            }
        enterprise_config_resource_name   = ""
    }
    ]
}

variable "bitbucket_server_trigger_config" {
  description = "BitbucketServerTriggerConfig describes the configuration of a trigger that creates a build whenever a Bitbucket Server event is received."
  type = list(object(
    {
        repo_slug                         = string
        project_key                       = string
        bitbucket_server_config_resource  = string
        pull_request                      = object(
            {
                branch                    = string
                invert_regex              = string
                comment_control           = string
            }
        )

        push                              = object(
            {
                branch                    = string
                tag                       = string
                invert_regex              = string
            }
        )

        enterprise_config_resource_name   = string
    }
    )
    )

  default = [
    {
        repo_slug                         = ""
        project_key                       = ""
        bitbucket_server_config_resource  = ""
        pull_request                      = {
                branch                    = ""
                invert_regex              = ""
                comment_control           = ""
            }

        push                              = {
                branch                    = ""
                tag                       = ""
                invert_regex              = ""
            }
        enterprise_config_resource_name   = ""
    }
    ]
}

variable "pubsub_config" {
  description = "PubsubConfig describes the configuration of a trigger that creates a build whenever a Pub/Sub message is published. One of trigger_template, github, pubsub_config webhook_config or source_to_build must be provided."
  type = list(object(
    {
        subscription                      = string
        topic                             = string
        service_account_email             = string
        state                             = string
    }
    )
    )

  default = [
    {
        subscription                      = ""
        topic                             = ""
        service_account_email             = ""
        state                             = ""
    }
    ]
}

variable "webhook_config" {
  description = "WebhookConfig describes the configuration of a trigger that creates a build whenever a webhook is sent to a trigger's webhook URL. One of trigger_template, github, pubsub_config webhook_config or source_to_build must be provided."
  type = list(object(
    {
        secret                            = string
        state                             = string
    }
    )
    )

  default = [
    {
        secret                            = ""
        state                             = ""
    }
    ]
}

variable "approval_config" {
  description = "Configuration for manual approval to start a build invocation of this BuildTrigger. Builds created by this trigger will require approval before they execute."
  type = list(object(
    {
        approval_required                 = string
    }
    )
    )

  default = [
    {
        approval_required                 = ""
    }
    ]
}

variable "build" {
  description = "Contents of the build template. Either a filename or build template must be provided."
  type = list(object(
    {
        source                            = object(
            {
                storage_source            = object(
                    {
                        bucket            = string
                        object            = string
                        generation        = string
                    }
                )
                repo_source               = object(
                    {
                    project_id            = string
                    repo_name             = string 
                    dir                   = string
                    invert_regex          = string
                    substitutions         = string
                    branch_name           = string
                    tag_name              = string
                    commit_sha            = string
                    }
                )
            }
            )

        tags                              = object(
            {
                images                    = string
                substitutions             = string
                queue_ttl                 = string
                logs_bucket               = string
                timeout                   = string
            }
        )
        secret                            = object(
            {
                kms_key_name              = string
                secret_env                = string 
            }
        )
        
        available_secrets                 = object(
            {
                secret_manager            = object(
                    {
                        version_name      = string
                        env               = string
                    }
                )
            }
        )

        step                              = object(
            {
                name                      = string
                args                      = string
                env                       = string
                id                        = string
                entrypoint                = string
                dir                       = string
                secret_env                = string
                timeout                   = string
                timing                    = string

                volumes                   = object(
                    {
                        name              = string
                        path              = string
                    }
                )

                wait_for                  = string
                script                    = string
            }
        )

        artifacts                         = object(
            {
                images                    = string
                objects                   = object(
                    {
                        location          = string
                        paths             = string
                        timing            = object(
                            {
                                start_time = string
                                end_time   = string
                            }
                        )
                    }
                )
            }
        )

        options                           = object(
            {
                source_provenance_hash    = string 
                requested_verify_option   = string
                machine_type              = string
                disk_size_gb              = string 
                substitution_option       = string
                dynamic_substitutions     = string
                log_streaming_option      = string
                worker_pool               = string
                logging                   = string
                env                       = string
                secret_env                = string

                volumes                   = object(
                    {
                        name              = string
                        path              = string
                    }
                )           
            }
        )
    }
    )
    )

  default = [
    {
        source                            = {
            storage_source                = {
                bucket                    = ""
                object                    = ""
                generation                = ""
            }
            
            repo_source                   = {
                project_id                = ""
                repo_name                 = "" 
                dir                       = ""
                invert_regex              = ""
                substitutions             = ""
                branch_name               = ""
                tag_name                  = ""
                commit_sha                = ""
            }
        }

        tags                              = {
            images                        = ""
            substitutions                 = ""
            queue_ttl                     = ""
            logs_bucket                   = ""
            timeout                       = ""
        }
    
        secret                            = {
            kms_key_name                  = ""
            secret_env                    = "" 
        }
        
        available_secrets                 = {
            secret_manager                = {
                version_name              = ""
                env                       = ""
            }
        }

        step                              = {
            name                          = ""
            args                          = ""
            env                           = ""
            id                            = ""
            entrypoint                    = ""
            dir                           = ""
            secret_env                    = ""
            timeout                       = ""
            timing                        = ""
            
            volumes                       = {
                name                      = ""
                path                      = ""
                }
            wait_for                      = ""
            script                        = ""
            }

        artifacts                         = {
            images                        = ""
            objects                       = {
                location                  = ""
                paths                     = ""
                timing                    = {
                    start_time            = ""
                    end_time              = ""
                }
            }
        }

        options                           = {
            source_provenance_hash        = "" 
            requested_verify_option       = ""
            machine_type                  = ""
            disk_size_gb                  = "" 
            substitution_option           = ""
            dynamic_substitutions         = ""
            log_streaming_option          = ""
            worker_pool                   = ""
            logging                       = ""
            env                           = ""
            secret_env                    = ""
            
            volumes                       = {
                name                      = ""
                path                      = ""
            }           
        }
    }
    ]
}

variable "location" {
  description = "The Cloud Build location for the trigger. If not specified, 'global' is used."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
}




variable "path" {
  description = "The path of the build trigger template to be used"
  type        = string
}
variable "uri" {
  description = "The uri of the build trigger template to be used"
  type        = string
}
variable "repo_type" {
  description = "The type of the repo for build trigger to be used"
  type        = string
}
variable "revision" {
  description = "The revision type of the repo for build trigger to be used"
  type        = string
}
variable "topic" {
  description = "The pubsub topic to be used"
  type        = string
}
variable "approval_required" {
  type        = string
}
