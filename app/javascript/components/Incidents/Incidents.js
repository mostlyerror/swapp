import React, { useState } from 'react'

const IncidentList = (props) => {
  return (
    <div className="max-w-lg mx-auto container p-2 md:p-6 text-lg text-gray-800">
      {props.incidents.map((incident, idx) => (
        <IncidentReport key={idx} {...incident} />
      ))}
    </div>
  )
}

const IncidentReport = (props) => {
  return (
    <div className="mt-4">
      <div className="flex gap-4 items-start">
        <div className="pt-2 max-w-xs bg-white flex items-center text-sm md:text-base rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          <span className="inline-flex items-center justify-center h-10 w-10 rounded-full bg-gray-500">
            <span className="text-sm md:text-base font-medium leading-none text-white">
              {`${props.reportedBy.firstName[0]}${props.reportedBy.lastName[0]}`}
            </span>
          </span>
        </div>
        <div className="">
          <p>
            <span className="font-semibold">Reported By:</span>{' '}
            {props.reportedBy.email}
          </p>
          <p className="mt-1">
            <span className="font-semibold">Date of Incident:</span>
            {new Date(props.dateOfIncident).toLocaleDateString()}
          </p>
          <p className="mt-3 text-xl leading-relaxed">{props.description}</p>
        </div>
      </div>
    </div>
  )
}

const Incidents = (props) => {
  const [formIsShowing, setFormIsShowing] = useState(false)

  return (
    <section className="bg-white rounded border border-gray-200 text-lg lg:text-xl text-gray-800">
      <div className="max-w-3xl mx-auto container p-2 md:p-6">
        <h4 className="mt-4 font-semibold tracking-normal">Incidents</h4>
        <IncidentList incidents={props.incidents} />

        {!formIsShowing && (
          <div className="flex justify-center">
            <button
              className="mt-4 px-4 cursor-pointer bg-indigo-600 hover:bg-indigo-700 text-white font-semibold tracking-wide uppercase shadow-md px-2 py-1 mr-2 rounded"
              onClick={() => setFormIsShowing(!formIsShowing)}
            >
              ⚠️ Report An Incident
            </button>
          </div>
        )}
        {formIsShowing && (
          <form method="POST" action={props.form_path} className="space-y-4">
            <div>
              <label className="block">When did this occur?</label>
              <input
                className="mt-1 rounded-md"
                type="date"
                name="date"
                defaultValue={props.incident_report.occurred_at || ''}
              />
            </div>
            <div>
              <label className="block">At which hotel did this occur?</label>
              <select className="mt-1 rounded-md" name="hotel_id">
                {Object.entries(props.hotel_map).map(([id, name], idx) => {
                  return (
                    <option key={idx} value={id}>
                      {name}
                    </option>
                  )
                })}
              </select>
            </div>
            <div>
              {/* <p className="font-bold">Incident Description</p> */}
              <p>Please describe the incident in detail.</p>
              <textarea
                className="mt-1 w-full h-32 resize-none rounded-md"
                name="description"
              />
            </div>
            <div className="flex items-center py-1 px-2 border border-gray-100 bg-admin-orange rounded-md">
              <div className="p-2">
                <input
                  className="w-6 h-6 rounded admin-blue
                border-2 border-black focus:border-indigo-500
                focus:ring-indigo-200 focus:ring-offset-0 focus:ring-3"
                  type="checkbox"
                  name="red_flag"
                  defaultValue={props.incident_report.red_flag || ''}
                />
              </div>
              <p>
                Check this box if the hotel wants to ban this client after this
                incident.
              </p>
            </div>
            <div className="flex justify-center">
              <button
                className="mt-4 px-4 cursor-pointer bg-indigo-600 hover:bg-indigo-700 text-white font-semibold tracking-wide uppercase shadow-md px-2 py-1 mr-2 rounded"
                type="submit"
              >
                ⚠️ Submit Incident
              </button>
            </div>
          </form>
        )}
      </div>
    </section>
  )
}

export default Incidents
