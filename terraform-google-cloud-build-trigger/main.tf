#.................................. Cloud Build Trigger ...................................#

resource "google_cloudbuild_trigger" "build-trigger" {
    provider                                      = google-beta       
    name                                          = var.name
    description                                   = var.description
    tags                                          = var.tags
    disabled                                      = var.disabled
    substitutions                                 = var.substitutions
    service_account                               = var.service_account
    include_build_logs                            = var.build_logs
    filename                                      = var.filename
    filter                                        = var.filter
    
    dynamic "git_file_source" {
        for_each = var.git_file_source[*]
            content {
                path                              = git_file_source.value.path
                uri                               = git_file_source.value.uri
                repo_type                         = git_file_source.value.repo_type 
                revision                          = git_file_source.value.revision
                github_enterprise_config          = git_file_source.value.github_enterprise_config 
        }
    }
    
    dynamic "repository_event_config" {
        for_each = var.repository_event_config[*]
            content {
                repository                        = repository_event_config.value.repository

                pull_request {
                    branch                        = repository_event_config.value.pull_request.branch
                    invert_regex                  = repository_event_config.value.pull_request.invert_regex
                    comment_control               = repository_event_config.value.pull_request.comment_control
                }

                push {
                    branch                        = repository_event_config.value.push.branch
                    tag                           = repository_event_config.value.push.tag
                    invert_regex                  = repository_event_config.value.push.invert_regex
                }
        }
    }

    dynamic "source_to_build" {
        for_each = var.source_to_build[*]
            content {
                uri                               = source_to_build.value.uri
                ref                               = source_to_build.value.ref
                repo_type                         = source_to_build.value.repo_type
                github_enterprise_config          = source_to_build.value.github_enterprise_config 
        }
    }

    ignored_files                                 = var.ignored_files
    included_files                                = var.included_files

    dynamic "trigger_template" {
        for_each = var.trigger_template[*]
        content {
            project_id                            = git_file_source.value.project_id
            repo_name                             = git_file_source.value.repo_name 
            dir                                   = git_file_source.value.dir 
            invert_regex                          = git_file_source.value.invert_regex
            branch_name                           = git_file_source.value.branch_name
            tag_name                              = git_file_source.value.tag_name
            commit_sha                            = git_file_source.value.commit_sha
        }
    }

    dynamic "github" {
        for_each = var.github[*]
        content {
            owner                                 = github.value.owner
            name                                  = github.value.name

            pull_request {
                branch                            = github.value.pull_request.branch
                invert_regex                      = github.value.pull_request.invert_regex
                comment_control                   = github.value.pull_request.comment_control
            }
                
            push {
                branch                            = github.value.push.branch
                tag                               = github.value.push.tag
                invert_regex                      = github.value.push.invert_regex
            }

            enterprise_config_resource_name       = github.value.enterprise_config_resource_name
        }
    }

    dynamic "bitbucket_server_trigger_config" {
        for_each = var.bitbucket_server_trigger_config[*]
        content {
            repo_slug                             = bitbucket_server_trigger_config.value.repo_slug
            project_key                           = bitbucket_server_trigger_config.value.project_key
            bitbucket_server_config_resource      = bitbucket_server_trigger_config.value.bitbucket_server_config_resource

            pull_request {
                branch                            = github.value.pull_request.branch
                invert_regex                      = github.value.pull_request.invert_regex
                comment_control                   = github.value.pull_request.comment_control
            }
                
            push {
                branch                            = github.value.push.branch
                tag                               = github.value.push.tag
                invert_regex                      = github.value.push.invert_regex
            }

            enterprise_config_resource_name       = github.value.enterprise_config_resource_name
        }
    }

    dynamic "pubsub_config" {
        for_each = var.pubsub_config[*]
        content {
            subscription                          = pubsub_config.value.subscription
            topic                                 = pubsub_config.value.topic
            service_account_email                 = pubsub_config.value.service_account_email
            state                                 = pubsub_config.value.state
        }
    }

    dynamic "webhook_config" {
        for_each = var.webhook_config[*]
        content {
            secret                                = webhook_config.value.secret
            state                                 = webhook_config.value.state
        }
    }

    dynamic "approval_config" {
        for_each = var.approval_config[*]
        content {
            approval_required                     = approval_config.value.approval_required 
        }
    }

    dynamic "build" {
        for_each = var.build[*]
        content {
            source {
                storage_source {
                    bucket                        = build.value.source.storage_source.bucket
                    object                        = build.value.source.storage_source.objects
                    generation                    = build.value.source.storage_source.generation
                }

                repo_source {
                    project_id                    = build.value.source.repo_source.project_id
                    repo_name                     = build.value.source.repo_source.repo_name 
                    dir                           = build.value.source.repo_source.dir 
                    invert_regex                  = build.value.source.repo_source.invert_regex
                    substitutions                 = build.value.source.repo_source.substitutions
                    branch_name                   = build.value.source.repo_source.branch_name
                    tag_name                      = build.value.source.repo_source.tag_name
                    commit_sha                    = build.value.source.repo_source.commit_sha
                }
            }

            tags                                  = build.value.tags
            images                                = build.value.images
            substitutions                         = build.value.substitutions
            queue_ttl                             = build.value.queue_ttl
            logs_bucket                           = build.value.logs_bucket
            timeout                               = build.value.timeout

            secret {
                kms_key_name                      = build.value.secret.kms_key_name
                secret_env                        = build.value.secret.secret_env 
            }

            available_secrets {
                secret_manager {
                    version_name                  = build.value.available_secrets.secret_manager.version_name
                    env                           = build.value.available_secrets.secret_manager.env
                }
            }

            step {
                name                              = build.value.step.name
                args                              = build.value.step.args
                env                               = build.value.step.env
                id                                = build.value.step.id
                entrypoint                        = build.value.step.entrypoint
                dir                               = build.value.step.dir
                secret_env                        = build.value.step.secret_env
                timeout                           = build.value.step.timeout
                timing                            = build.value.step.timing

                volumes {
                    name                          = build.value.step.volumes.name
                    path                          = build.value.step.volumes.path
                }

                wait_for                          = build.value.step.wait_for
                script                            = build.value.step.script

            }

            artifacts {
                images                            = build.value.artifacts.images
                objects {
                    location                      = build.value.artifacts.objects.location
                    paths                         = build.value.artifacts.objects.paths
                    timing {
                        start_time                = build.value.artifacts.objects.timing.start_time
                        end_time                  = build.value.artifacts.objects.timing.end_time
                    }
                }
            }

            options {
                source_provenance_hash            = build.value.options.source_provenance_hash 
                requested_verify_option           = build.value.options.requested_verify_option
                machine_type                      = build.value.options.machine_type
                disk_size_gb                      = build.value.options.disk_size_gb 
                substitution_option               = build.value.options.substitution_option 
                dynamic_substitutions             = build.value.options.dynamic_substitutions
                log_streaming_option              = build.value.options.log_streaming_option
                worker_pool                       = build.value.options.worker_pool 
                logging                           = build.value.options.logging
                env                               = build.value.options.env
                secret_env                        = build.value.options.secret_env

                volumes {
                    name                          = build.value.options.volumes.name
                    path                          = build.value.options.volumes.path
                }           
            }
        }
    }
    
    location                                      = var.location
    project                                       = var.project_id
}