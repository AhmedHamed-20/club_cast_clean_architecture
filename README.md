# club_cast

# Live interactive voice stream and podcast app
it's a social media built on voice ✔👌

<img src="https://user-images.githubusercontent.com/72945669/222990407-30ff49b3-0221-4e3c-89d6-865a8657223d.png" width="280">

# Features
- create public and private live voice streaming rooms
- ability to record your rooms
- admin can accept someone's request to become a speaker or not
- admin can return any speaker to the listener part
- any user can mute and unmute any speaker
- any user can know if the admin record the room or not
- public and private chat with any user in the room
- any user able to remove his chat message
- create, update, and know upcoming events
- notify the user on the event date if he activates this
- follow and discover your favorite people
- listen, upload, play, and download podcasts
- interaction with any podcast with likes
- ability to play rooms or podcasts in the background
- edit your profile information (photo-name-bio-password)
- search about (users-podcasts-public rooms)
- ability to change app theme color with 4 available themes and each theme support light and dark version
- localization support (arabic - english)

# Technologies
- flutter
- agora
- socket_io

# Common Packages
- Equatable for objects equality
- get_it for dependency injection
- assetts_audio_player for playing podcasts files
- bloc for state management
- flutter_local_notifications for events notifications
- Dio for HTTP requests
- dartz for returning two values from functions
- shared preferences for cache access tokens

# Screenshots

<img src="https://user-images.githubusercontent.com/72945669/223179616-619c8082-9155-4324-982e-e70107388d1f.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179621-9083544e-2d2b-432e-93c8-4634787d496d.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179626-eea5351b-6a11-4d85-8aa9-901d369bfb6c.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179639-8d9288eb-7b74-4da0-946a-794c81bb92b4.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179650-e87be579-2dcb-4aed-8d32-f9340cf259fb.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179662-c81220ef-3f81-4146-a57b-60902e12f045.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179668-0ac7e9bc-7421-4e32-bcab-72e60d147e4d.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179673-97b7007b-4eb0-4c2c-8059-1262b17d7f24.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179677-35875ace-caa6-4324-addf-f403125d1ffb.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179680-519152a5-7344-4713-b393-6fa29b6b0d0d.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179692-062fad4c-4015-423e-9c6d-e957144ba78a.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179701-9d3d2bb6-ff71-4d3f-b01f-bf49c005a930.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179706-3c790211-2239-426b-8fe8-c4c59980a984.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179523-3432e320-b623-4b3f-a9c9-08b340ce8bb4.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179541-6de283df-db75-45e5-a598-12bb2f790dc6.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179548-7eca827d-a5f4-46d5-be1c-1d6376ac795a.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179556-c452c196-f5d9-47d0-b997-7f1dc447ad80.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179561-d3abe0ff-0d98-4145-8767-b25482d297af.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179564-3804819e-d7f0-4ca6-97de-6c360afc956a.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179569-5513ae96-9988-4ced-89e0-20099f203482.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179571-1e6d71cc-51b0-4760-84c4-f16b8f5b5905.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179587-aabcc39b-5ad2-435f-9833-6731e86ea7ae.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179592-ed4413af-050d-457b-944f-0f8409fd5af7.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179604-52af9aa8-d05d-4346-9d0d-80f7a2672b39.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179577-e134c78d-66e1-438c-8f42-041984ffeb9e.png" width="280"><img src="https://user-images.githubusercontent.com/72945669/223179583-69a12d8d-d603-4aa2-8cd6-61414f63bd0b.png" width="280">

# Web
https://github.com/waleedsalah4/ARCH-CLUB

# Backend
https://github.com/omarbadawy/audiocomms-podcast-api

⚠️ server sleeps every 15 minutes if there is no request sent so it's may take some time if the server is in sleep mode to response

⚠️ there is a bug in the server that any socket connection still alive for 5 minutes only due to free plan of the server

