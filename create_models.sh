rails db:drop
rails db:create

rails g model Country name:string
rails g model Category name:string
rails g model Directors full_name:string biography:string date_of_birth:date image:string country:references
rails g model Actor full_name:string biography:string date_of_birth:string image:string country:references 
rails g model Movie name:string description:string{500} video_key:string release_date:date duration:time category:references director:references
rails g model Serial name:string description:string{500} video_key:string release_date:date duration:time category:references director:references
rails g model Season name:string description:string{500} image:string duration:time number:integer serial:references
rails g model Series name:string description:string{500} image:string duration:time number:integer season:references
rails g model Movies_Actors movie:references actor:references 
rails g model Movies_Country movie:references country:references
rails g model Seasons_Actor season:references actor:references 
rails g model Serial_Country serial:references actor:references

rails db:migrate