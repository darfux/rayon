CREATE TABLE  `schema_migrations` (
`version` varchar(255) NOT NULL
);

CREATE UNIQUE INDEX  `unique_schema_migrations` ON  `schema_migrations` (
`version`
);

CREATE TABLE  `sources` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `project_types` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `project_states` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `created_at` datetime,
  `updated_at` datetime,
  `name` varchar(255)
);

CREATE TABLE  `project_users` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `user_id` integer,
  `project_id` integer,
  `participation_type_id` integer,
  `created_at` datetime,
  `updated_at` datetime,
  FOREIGN KEY (user_id) REFERENCES users(`id`),
  FOREIGN KEY (project_id) REFERENCES projects(`id`),
  FOREIGN KEY (participation_type_id) REFERENCES participation_types(`id`)
);

CREATE TABLE  `participation_types` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `achievements` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `title` varchar(255),
  `description` text,
  `created_at` datetime,
  `updated_at` datetime,
  `user_id` integer,
  FOREIGN KEY (user_id) REFERENCES users(`id`)
);

CREATE TABLE  `titles` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `projects` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `description` text,
  `created_at` datetime,
  `updated_at` datetime,
  `start` date,
  `end` date,
  `source_id` integer,
  `project_state_id` integer,
  `project_type_id` integer,
  FOREIGN KEY (source_id) REFERENCES sources(`id`),
  FOREIGN KEY (project_state_id) REFERENCES project_states(`id`),
  FOREIGN KEY (project_type_id) REFERENCES project_types(`id`)
);

CREATE TABLE  `research_directions` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `description` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `users` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `uid` integer,
  `name` varchar(255),
  `password_digest` varchar(255),
  `email` varchar(255),
  `created_at` datetime,
  `updated_at` datetime,
  `title_id` integer,
  FOREIGN KEY (title_id) REFERENCES titles(`id`)
);

CREATE TABLE  `research_directions_users` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `user_id` integer,
  `research_direction_id` integer,
  `created_at` datetime,
  `updated_at` datetime,
  FOREIGN KEY (user_id) REFERENCES users(`id`),
  FOREIGN KEY (research_direction_id) REFERENCES research_directions(`id`)
);

CREATE TABLE  `paper_users` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `paper_id` integer,
  `user_id` integer,
  `user_own_type_id` integer,
  `created_at` datetime,
  `updated_at` datetime,
  FOREIGN KEY (user_id) REFERENCES users(`id`),
  FOREIGN KEY (paper_id) REFERENCES papers(`id`),
  FOREIGN KEY (user_own_type_id) REFERENCES user_own_types(`id`)
);

CREATE TABLE  `user_own_types` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `name` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE  `papers` (
  `id` INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  `title` varchar(255),
  `publish` varchar(255),
  `created_at` datetime,
  `updated_at` datetime
);

