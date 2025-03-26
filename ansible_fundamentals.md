## Ansible fundamentals

### Inventory
An inventory file (`ansible/inventory/hosts`) lists the servers that Ansible manages. It can group servers and define variables for them.

### Playbooks
Playbooks are YAML files that define a series of tasks to be executed on the managed servers.

### Roles
Roles (`ansible/roles/`) are a way to organize playbooks into reusable components. Each role can have its own tasks, handlers, variables, and templates.

### Tasks
Tasks are the individual units of work in a playbook or role. They define actions to be performed on the managed servers, such as installing packages or configuring services.

### Handlers
Handlers are similar to tasks but are only run when notified by other tasks. They are typically used to restart services after configuration changes.

### Variables
Variables are used to store values that can be reused throughout playbooks and roles. They can be defined in inventory files, playbooks, or roles.

### Modules
Modules are the building blocks of tasks. Ansible provides a wide range of modules to perform various actions, such as `apt` for package management, `git` for version control, and `systemd` for service management.

### Templates
Templates are files that contain variables and are processed by Ansible to generate configuration files. They are typically written in Jinja2 templating language.

### Ansible States

When Ansible executes tasks, it reports the state of each task. The possible states are:

1. **ok**: The task was executed successfully, and no changes were made.
2. **changed**: The task was executed successfully, and changes were made to the system.
3. **failed**: The task failed to execute.
4. **skipped**: The task was skipped due to a condition not being met (e.g., `when` clause).
5. **unreachable**: The host was unreachable, and the task could not be executed.


### Other Ansible Concepts

Here are some other important concepts in Ansible:

### Idempotency
Ansible tasks are designed to be idempotent, meaning they can be run multiple times without changing the system after the first run. This ensures that the system reaches and maintains the desired state.

### Facts
Facts are system properties collected by Ansible from managed nodes. They provide information about the system, such as OS type, network interfaces, and hardware details. Facts can be used in playbooks and roles to make decisions.

### Conditionals
Ansible allows you to use conditionals to control task execution. The `when` keyword is used to specify conditions under which a task should run.

### Loops
Ansible supports loops to repeat tasks multiple times with different items. The `with_items` keyword is commonly used for this purpose.

### Tags
Tags allow you to run specific parts of your playbooks. You can tag tasks and then run only those tasks by specifying the tag during execution.

### Vault
Ansible Vault is a feature that allows you to encrypt sensitive data, such as passwords and keys, within your playbooks and roles.

### Dynamic Inventory
In addition to static inventory files, Ansible supports dynamic inventory scripts that can generate inventory data on the fly from external sources, such as cloud providers or databases.

### Ansible Galaxy
Ansible Galaxy is a repository for sharing Ansible roles. You can download and use roles from Galaxy to speed up your development process.

### Ansible Tower
Ansible Tower is an enterprise solution for managing Ansible automation. It provides a web-based interface, role-based access control, job scheduling, and more.

