package types

type Config struct {
	Port     int    `yaml:"port"`
	Endpoint string `yaml:"endpoint"`
	Host     string `yaml:"host"`
	Schema   string `yaml:"schema"`
	User     string `yaml:"user"`
	Password string `yaml:"password"`
}

type Query struct {
	ID  string `query:"id"`
	CID string `query:"cid"`
}

type Response struct {
	ID    int    `json:"id"`
	Name  string `json:"name"`
	Email string `json:"email"`
}
